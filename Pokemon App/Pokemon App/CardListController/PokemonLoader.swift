//
//  PokemonLoader.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 12/11/22.
//

import Foundation

enum PokemonResult {
    case Success ([PokemonModel])
    case failure (String)
}

//class PokemonLoader {
//    //call API pokemon
//    func getPokemonCard (completion: @escaping (PokemonResult) -> Void) {
//        guard let url = URL(string: "https://api.pokemontcg.io/v2/cards") else { return }
//        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                do {
//                    let cards = try self.transformJsonDataToCardList(with:data!)
//                    completion (.Success(cards))
//                } catch let error {
//                    let errorMessage = error.localizedDescription
//                    completion (.failure(errorMessage))
//                }
//            }
//        }.resume()
//    }
//
//    func transformJsonDataToCardList(with data: Data) throws -> [PokemonModel]  {
//        let decoder = JSONDecoder()
//    }
//}
