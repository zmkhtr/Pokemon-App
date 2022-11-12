//
//  CategoryListLoader.swift
//  Pokemon App
//
//  Created by Nadia Darin on 12/11/22.
//

import Foundation
//import UIKit


class CategoryListLoader {
    
    typealias CategoryListResult = Swift.Result<[String], Error>
    
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
                        completion(.failure(CustomError.unexpectedData))
                        
                    }
                } catch let error {
                    completion(.failure(error))
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

enum CustomError: Error {
    case unexpectedData
}

