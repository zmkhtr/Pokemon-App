//
//  CardListViewController.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import UIKit

class CardListViewController: UIViewController {
    
    @IBOutlet var cardListSearchBar: UISearchBar!
    
    
    @IBOutlet weak var categoryListCollectionView: CategoryListCollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        setUpCategoryList()
        loadCategories()
    }
    
    func loadCategories() {
        let loader = CategoryListLoader()
        loader.getCategories { result in
            switch result {
            case .success(let categoriesListResult):
                self.successLoadPokemon(categoriesListResult)
            case .failure(let err):
                self.failedLoadPokemon(err)
            }
        }
    }
    
    private func successLoadPokemon(_ pokemonListResult: [String]) {
        DispatchQueue.main.async {
            self.categoryListCollectionView.categoryList = pokemonListResult
            self.categoryListCollectionView.selectedCategory = pokemonListResult.count > 0 ? pokemonListResult.first! : ""
            self.categoryListCollectionView.reloadData()
        }
    }
    
    private func failedLoadPokemon(_ err: String) {
        // TODO: failed categories??
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
        
        navigationItem.titleView = cardListSearchBar
    }
    
    private func setUpCategoryList() {
        categoryListCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        categoryListCollectionView.delegate = categoryListCollectionView.self
        categoryListCollectionView.dataSource = categoryListCollectionView.self
        categoryListCollectionView.showsHorizontalScrollIndicator = false
    }
}
