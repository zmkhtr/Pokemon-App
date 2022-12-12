//
//  ListPokemonViewController.swift
//  Pokemon App
//
//  Created by PT.Koanba on 21/10/22.
//

import UIKit

class ListPokemonViewController: UIViewController {
    
    @IBOutlet private var pokemonSearchBar: UISearchBar!
    @IBOutlet private weak var listPokemonTypeView: ListPokemonTypeView!
    @IBOutlet private weak var listPokemonView: ListPokemonView!
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonViewToSearchPokemonQueryViewConstraint: NSLayoutConstraint!
    @IBOutlet var pokemonViewToPokemonTypeViewConstraint: NSLayoutConstraint!
    
    private let pokemonLoader = PokemonLoaderImpl()
    private let currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        retrieveListPokemonType()
        retrieveListPokemon()
        listPokemonTypeViewListener()
        listPokemonViewListener()
    }

    private func configureSearchBar() {
        self.navigationItem.titleView = pokemonSearchBar
        pokemonSearchBar.searchTextField.textColor = UIColor(named: "SearchBarTextColor")
        pokemonSearchBar.searchTextField.leftView?.tintColor = UIColor(named: "SearchBarTextColor")
        pokemonSearchBar.searchTextField.clearButtonMode = .never
        pokemonSearchBar.delegate = self
    }
    
    private func retrieveListPokemonType() {
        pokemonLoader.getListPokemonType { [weak self] result in
            self?.listPokemonTypeView.bindResult(result)
        }
    }
    
    private func retrieveListPokemon() {
        pokemonLoader.getListPokemon(currentPage: currentPage) { [weak self] result in
            self?.listPokemonView.bindResult(result)
        }
    }
    
    private func listPokemonTypeViewListener() {
        listPokemonTypeView.tapToRetry = { [weak self] in
            self?.retrieveListPokemon()
        }
    }
    
    private func listPokemonViewListener() {
        listPokemonView.refreshData = { [weak self] in
            self?.retrieveListPokemon()
        }
    }
    
    private func retrieveSearchedPokemons(searchText: String) {
        pokemonLoader.getSearchedPokemon(name: searchText) { [weak self] result in
            self?.listPokemonView.bindResult(result, isSearching: true, searchedPokemon: searchText)
        }
    }
}

extension ListPokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            pokemonNameLabel.text = nil
            pokemonViewToSearchPokemonQueryViewConstraint.isActive = true
            pokemonViewToPokemonTypeViewConstraint.isActive = false
            retrieveListPokemon()
        } else {
            pokemonNameLabel.text = "Showing result of '\(searchText)'"
            pokemonViewToSearchPokemonQueryViewConstraint.isActive = true
            pokemonViewToPokemonTypeViewConstraint.isActive = false
            retrieveSearchedPokemons(searchText: searchText)
        }
    }
}
