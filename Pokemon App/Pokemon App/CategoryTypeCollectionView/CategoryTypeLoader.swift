//
//  CategoryTypeLoader.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 02/12/22.
//

import Foundation
enum ListPokemonTypeResult {
    case loading(Bool)
    case success([PokemonCards])
    case failure(String)
}
class CategoryTypeLoader {
    
    typealias CategoryTypeResult = Swift.Result<[String], Error>
    
    func getPokemonTypeData (completion: @escaping (CategoryTypeResult) -> Void) {
        let url = URL(string: "https://api.pokemontcg.io/v2/types")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        do {
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                let pokemonType = try self.transformJsonDataToTypeList(with: data)
                completion(.success(pokemonType))
            } else {
                completion(.failure("Unexpected Data" as! Error))
            }
        } catch let error {
            
            completion( .failure(error.localizedDescription as! Error))
        }
            }.resume()
    }

    func transformJsonDataToTypeList(with data: Data) throws -> [String] {
        let decoder = JSONDecoder()
        let cardTypes = try decoder.decode(RemotePokemonTypes.self, from: data)
        let pokemonTypes = cardTypes.data as [String]
        return pokemonTypes
        }
        
        }
     

