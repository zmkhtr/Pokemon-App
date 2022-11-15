//
//  PokemonLoader.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 12/11/22.
//

import Foundation

enum PokemonResult {
    case Success ([PokemonCardsModel])
    case failure (String)
}

class PokemonLoader {
    //call API pokemon
    func getPokemonCardData (completion: @escaping (PokemonResult) -> Void) {
        let url = URL(string: "https://api.pokemontcg.io/v2/cards")!
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    let cards = try self.transformJsonDataToCardList(with:data!)
                    completion (.Success(cards))
                } catch let error {
                    let errorMessage = error.localizedDescription
                    completion (.failure(errorMessage))
                }
            }
        }.resume()
    }
    
    func transformJsonDataToCardList(with data: Data) throws -> [PokemonCardsModel]  {
        let decoder = JSONDecoder()
        let cardLists = try decoder.decode([PokemonCardsModel].self, from: data)
        let pokemonLists = cardLists.map { pokemonCardsModel in
            return map (pokemonCardsModel: pokemonCardsModel)
        }
        return pokemonLists
        
        private func map(pokemonCardsModel: QTPokemonCardsModel) -> PokemonCardsModel{
            return PokemonCardsModel(id: PokemonCardsModel.id, imageURL: PokemonCardsModel.images)
        }
    }
}
