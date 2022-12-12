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
    
    private var pokemonSearchText: String? = nil
    private var selectedPokemonType: String? = nil

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
        
        listPokemonTypeView.tapPokemonType = { [weak self] type in
            self?.selectedPokemonType = type
            self?.retrievePokemonsByType(type: type)
        }
    }
    
    private func listPokemonViewListener() {
        listPokemonView.refreshData = { [weak self] in
            self?.retrieveListPokemon()
            self?.listPokemonTypeView.resetListPokemonType()
            self?.resetView()
        }
    }
    
    private func retrieveSearchedPokemons(searchText: String) {
        pokemonLoader.getSearchedPokemon(name: searchText) { [weak self] result in
            self?.listPokemonView.bindResult(result, isSearching: true, searchedPokemon: searchText)
        }
    }
    
    private func retrievePokemonsByType(type: String) {
        pokemonLoader.getPokemonsByType(currentPage: currentPage, type: type, name: pokemonSearchText) { [weak self] result in
            self?.listPokemonView.bindResult(result, isFiltering: true, searchedPokemon: self?.selectedPokemonType ?? "")
        }
    }
    
    private func resetView() {
        pokemonNameLabel.text = nil
        pokemonSearchText = nil
        pokemonSearchBar.text = nil
        pokemonViewToSearchPokemonQueryViewConstraint.isActive = true
        pokemonViewToPokemonTypeViewConstraint.isActive = false
    }
}

extension ListPokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonSearchText = searchText
        
        if searchText.isEmpty {
            pokemonNameLabel.text = nil
            pokemonViewToSearchPokemonQueryViewConstraint.isActive = true
            pokemonViewToPokemonTypeViewConstraint.isActive = false
            
            if let selectedPokemonType = selectedPokemonType {
                retrievePokemonsByType(type: selectedPokemonType)
            } else {
                retrieveListPokemon()
            }
        } else {
            pokemonNameLabel.text = "Showing result of '\(searchText)'"
            pokemonViewToSearchPokemonQueryViewConstraint.isActive = true
            pokemonViewToPokemonTypeViewConstraint.isActive = false
            retrieveSearchedPokemons(searchText: searchText)
        }
    }
}
