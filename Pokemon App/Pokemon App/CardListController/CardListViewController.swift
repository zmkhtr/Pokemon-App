//
//  CardListController.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 12/11/22.
//

import Foundation
import UIKit

class CardListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var listCard: [PokemonCards] = [] {
        didSet {
            self.cardListCollectionView.reloadData()
        }
    }
    
    var loader = PokemonLoader()
    @IBOutlet var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var cardListCollectionView: UICollectionView!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        setupCollectionView()
        getPokemonCardData()
        
    }
    //showErroLabel Method
    func showErrorLabel(with message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    @objc
    func refresh() {
        listCard.removeAll()
        getPokemonCardData()
    }
    func startRefreshing() {
        refreshControl.beginRefreshing()
    }
    func stopRefreshing() {
        refreshControl.endRefreshing()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XibPokemonCard", for: indexPath) as! CardCollectionViewCell
        let cards = listCard[indexPath.row]
        cell.downloadPokemonCardImage(for: URL(string: "\(cards.imageURL)")!)
        return cell
    }
    
//MARK: Search Bar
    
    let searchController = UISearchController()
}
//MARK: Networking
extension CardListViewController {
    func getPokemonCardData() {
        startRefreshing()
        loader.getPokemonCardData { result in
           
            switch result {
            case .Success (let pokemonCards):
                self.listCard = pokemonCards.shuffled()
                //self.bindData (with: pokemonCards)
            case .failure (let error):
                self.showErrorLabel(with: error)
            }
            self.stopRefreshing()
        }
    }
    //bindData Method
    func bindData (with pokemonCards: [PokemonCards]) {
        DispatchQueue.main.async {
            
        }
    }
    //setup CollectionView
    func setupCollectionView() {
        cardListCollectionView.delegate = self
        cardListCollectionView.dataSource = self
        //Register XIB dengan CardCollectionViewCell dan identifier XibPokemonCard
        self.cardListCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "XibPokemonCard")
        cardListCollectionView.refreshControl = refreshControl
    }
    
}

