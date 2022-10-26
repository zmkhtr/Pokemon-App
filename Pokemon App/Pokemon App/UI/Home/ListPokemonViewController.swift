//
//  ListPokemonViewController.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 24/10/22.
//

import UIKit

class ListPokemonViewController: UIViewController {

    @IBOutlet private weak var listPokemonView: ListPokemonView!
    private let pokemonLoader = PokemonLoaderImpl()
    private let currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        retrieveListPokemon()
        
        listPokemonView.refreshData = { [weak self] in
            self?.retrieveListPokemon()
        }
    }
    
    private func retrieveListPokemon() {
        pokemonLoader.getListPokemon(currentPage: currentPage) { [weak self] result in
            self?.listPokemonView.bindResult(result)
        }
    }
}
