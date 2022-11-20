//
//  ListPokemonViewController.swift
//  Pokemon App
//
//  Created by PT.Koanba on 21/10/22.
//

import UIKit

class ListPokemonViewController: UIViewController {
    
    @IBOutlet private var pokemonSearchBar: UISearchBar!
    @IBOutlet private weak var listPokemonView: ListPokemonView!
    private let pokemonLoader = PokemonLoaderImpl()
    private let currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        retrieveListPokemon()
        
        listPokemonView.refreshData = { [weak self] in
            self?.retrieveListPokemon()
        }
    }

    private func configureSearchBar() {
        self.navigationItem.titleView = pokemonSearchBar
        pokemonSearchBar.searchTextField.textColor = UIColor(named: "SearchBarTextColor")
        pokemonSearchBar.searchTextField.leftView?.tintColor = UIColor(named: "SearchBarTextColor")
        pokemonSearchBar.searchTextField.clearButtonMode = .never
    }
    
    private func retrieveListPokemon() {
        pokemonLoader.getListPokemon(currentPage: currentPage) { [weak self] result in
            self?.listPokemonView.bindResult(result)
        }
    }
}
