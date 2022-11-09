//
//  PokemonCardListLoader.swift
//  Pokemon App
//
//  Created by Nadia Darin on 06/11/22.
//

import Foundation
import UIKit

enum PokemonCardListResult {
    case success([PokemonCard])
    case failure(String)
}

class PokemonCardListLoader {
    
    func getMovieList(completion: @escaping (PokemonCardListResult) -> Void) {
        let url = URL(string: "https://api.pokemontcg.io/v2/cards?pageSize=10")!
        
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.sync {
                do {
                    let movies = try self.transformJsonDataToMovieList(with: data!)
                    completion(.success(movies))
                } catch let error {
                    
                    let errorMessage = error.localizedDescription
                    completion(.failure(errorMessage))
                }
            }
        }.resume()
    }
    
    private func transformJsonDataToMovieList(with data: Data) throws -> [PokemonCard] {
        let decoder = JSONDecoder()
        let pokemonCardList = try decoder.decode(PokemonCardList.self, from: data)
        let listOfPokemon = pokemonCardList.data.map { remotePokemon in
            return map(remotePokemon: remotePokemon)
        }
        return listOfPokemon
    }
    
    private func map(remotePokemon: RemotePokemonCard) -> PokemonCard {
        return PokemonCard(id: remotePokemon.id, imageURL: remotePokemon.images.large)
    }
}

