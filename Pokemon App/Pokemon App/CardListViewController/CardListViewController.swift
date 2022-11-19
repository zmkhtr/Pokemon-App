//
//  CardListViewController.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import UIKit

class CardListViewController: UIViewController {
    
    @IBOutlet var cardListSearchBar: UISearchBar!
    @IBOutlet weak var cardListCollectionView: CardListCollectionView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loadingCardListIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var categoryListCollectionView: CategoryListCollectionView!
    @IBOutlet weak var errorCategoriesLabel: UILabel!
    @IBOutlet weak var retryCategoriesButton: UIButton!
    @IBOutlet weak var loadingCategoriesIndicator: UIActivityIndicatorView!
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        setUpCardListCollectionView()
        loadPokemon()
        setUpCategoryList()
        loadCategories()
        
    }
    
    @objc
    private func refresh() {
        cardListCollectionView.pokemonList = []
        cardListCollectionView.reloadData()
        loadPokemon()
    }
    
    private func startRefreshing() {
        refreshControl.beginRefreshing()
    }
    
    private func setUpSearchBar(){
        let whiteColor = UIColor.white.withAlphaComponent(0.6)
        
        cardListSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: whiteColor]
        )
        
        cardListSearchBar.searchTextField.textColor = .white
        
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(whiteColor, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setImage(image, for: .search, state: .normal)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "PrimaryColor")
       
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationItem.compactScrollEdgeAppearance = appearance
           }
        navigationItem.titleView = cardListSearchBar
    }
    
    private func setUpCardListCollectionView() {
        cardListCollectionView.delegate = cardListCollectionView.self
        cardListCollectionView.dataSource = cardListCollectionView.self
        cardListCollectionView.prefetchDataSource = cardListCollectionView.self
        cardListCollectionView.refreshControl = refreshControl
        cardListCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")        
    }
    
    private func setUpCategoryList() {
        categoryListCollectionView.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListCollectionViewCell")
        categoryListCollectionView.delegate = categoryListCollectionView.self
        categoryListCollectionView.dataSource = categoryListCollectionView.self
        categoryListCollectionView.showsHorizontalScrollIndicator = false
        categoryListCollectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15);
    }
    
    private func loadPokemon() {
        let loader = PokemonCardListLoader()
        startLoadPokemon()
        loader.getPokemonList { result in
            switch result {
            case .success(let pokemonListResult):
                self.successLoadPokemon(pokemonListResult)
            case .failure(let err):
                self.failedLoadPokemon(err)
            }
        }
    }
    
    private func startLoadPokemon() {
        DispatchQueue.main.async {
            self.loadingCardListIndicatorView.isHidden = false
            self.errorMessageLabel.isHidden = true
        }
    }
    
    private func successLoadPokemon(_ pokemonListResult: [PokemonCard]) {
        DispatchQueue.main.async {
            self.loadingCardListIndicatorView.isHidden = true
            self.errorMessageLabel.isHidden = true
            self.cardListCollectionView.pokemonList = pokemonListResult
            self.cardListCollectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func failedLoadPokemon(_ err: String) {
        DispatchQueue.main.async {
            self.loadingCardListIndicatorView.isHidden = true
            self.errorMessageLabel.isHidden = false
        }
    }
    
    private func loadCategories() {
        let loader = CategoryListLoader()
        startLoadCategories()
        loader.getCategories { result in
            switch result {
            case .success(let categoriesListResult):
                self.successLoadCategories(categoriesListResult)
            case .failure(let err):
                self.failedLoadCategories(err.localizedDescription)
            }
        }
    }
    
    private func startLoadCategories() {
        DispatchQueue.main.async {
            self.loadingCategoriesIndicator.isHidden = false
            self.errorCategoriesLabel.isHidden = true
            self.retryCategoriesButton.isHidden = true
        }
    }
    
    private func successLoadCategories(_ pokemonListResult: [String]) {
        DispatchQueue.main.async {
            self.loadingCategoriesIndicator.isHidden = true
            self.errorCategoriesLabel.isHidden = true
            self.retryCategoriesButton.isHidden = true
            self.categoryListCollectionView.categoryList = pokemonListResult
            self.categoryListCollectionView.selectedCategory = pokemonListResult.count > 0 ? pokemonListResult.first! : ""
            self.categoryListCollectionView.reloadData()
        }
    }
    
    private func failedLoadCategories(_ err: String) {
        self.loadingCategoriesIndicator.isHidden = true
        self.errorCategoriesLabel.isHidden = false
        self.retryCategoriesButton.isHidden = false
    }
}
