//
//  ViewController.swift
//  Pokemon App
//
//  Created by PT.Koanba on 21/10/22.
//

import UIKit

class ListPokemonViewController: UIViewController {
    
    @IBOutlet private var pokemonSearchBar: UISearchBar!
    @IBOutlet private weak var listPokemonView: ListPokemonView!
    @IBOutlet private weak var pokemonTypeCollectionView: UICollectionView!
    
    private let pokemonLoader = PokemonLoaderImpl()
    private let currentPage = 1
    private var listPokemonType: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configurePokemonTypeCollectionView()
        retrieveListPokemonType()
        retrieveListPokemon()
        
        listPokemonViewListener()
    }

    private func configureSearchBar() {
        self.navigationItem.titleView = pokemonSearchBar
        pokemonSearchBar.searchTextField.textColor = UIColor(named: "SearchBarTextColor")
        pokemonSearchBar.searchTextField.leftView?.tintColor = UIColor(named: "SearchBarTextColor")
        pokemonSearchBar.searchTextField.clearButtonMode = .never
    }
    
    private func configurePokemonTypeCollectionView() {
        pokemonTypeCollectionView.delegate = self
        pokemonTypeCollectionView.dataSource = self
        pokemonTypeCollectionView.register(PokemonTypeCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonTypeCollectionViewCell.identifier)
        pokemonTypeCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func retrieveListPokemonType() {
        pokemonLoader.getListPokemonType { [weak self] result in
            switch result {
            case .loading(let isLoading):
                print("Loading... \(isLoading)")
            case .success(let listPokemonType):
                self?.listPokemonType = listPokemonType.data
                DispatchQueue.main.async {
                    self?.pokemonTypeCollectionView.reloadData()
                }
            case .failure(let errorMessage):
                print("Error Message \(errorMessage)")
            }
        }
    }
    
    private func retrieveListPokemon() {
        pokemonLoader.getListPokemon(currentPage: currentPage) { [weak self] result in
            self?.listPokemonView.bindResult(result)
        }
    }
    
    private func listPokemonViewListener() {
        listPokemonView.refreshData = { [weak self] in
            self?.retrieveListPokemon()
        }
    }
}

extension ListPokemonViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pokemonTypeCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ListPokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPokemonType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonTypeCollectionViewCell.identifier, for: indexPath) as! PokemonTypeCollectionViewCell
        
        cell.configure(type: listPokemonType[indexPath.row])
        
        return cell
    }
}
