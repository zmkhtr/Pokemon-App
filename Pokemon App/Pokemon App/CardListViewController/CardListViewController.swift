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
        
        navigationItem.titleView = cardListSearchBar
    }
    
    private func setUpCardListCollectionView() {
        cardListCollectionView.delegate = cardListCollectionView.self
        cardListCollectionView.dataSource = cardListCollectionView.self
        cardListCollectionView.refreshControl = refreshControl
        cardListCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        
        
    }
    
    func loadPokemon() {
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
    
    
}
