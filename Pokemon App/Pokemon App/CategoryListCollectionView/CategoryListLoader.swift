//
//  CategoryListLoader.swift
//  Pokemon App
//
//  Created by Nadia Darin on 12/11/22.
//

import Foundation
//import UIKit

enum CategoryListResult {
    case success([String])
    case failure(String)
}

class CategoryListLoader {
    
    func getCategories(completion: @escaping (CategoryListResult) -> Void) {
        let url = URL(string: "https://api.pokemontcg.io/v2/types")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.sync {
                do {
                    if let data = data,
                       let response = response as? HTTPURLResponse,
                       response.statusCode == 200 {
                        let listOfPokemon = try self.transformJsonDataToListOfPokemonCard(with: data)
                        completion(.success(listOfPokemon))
                    } else {
                        completion(.failure("Unexpected Data"))
                    }
                } catch let error {
                    let errorMessage = error.localizedDescription
                    completion(.failure(errorMessage))
                }
            }
        }.resume()
    }
    
    private func transformJsonDataToListOfPokemonCard(with data: Data) throws -> [String] {
        let decoder = JSONDecoder()
        let categories = try decoder.decode(RemoteCategories.self, from: data)
        let listOfPokemon = categories.data as [String]
        return listOfPokemon
    }
    
}
