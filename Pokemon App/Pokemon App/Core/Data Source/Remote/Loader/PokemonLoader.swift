//
//  PokemonLoader.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import Foundation
import UIKit

enum ListPokemonResult {
    case loading(Bool)
    case success([Pokemon])
    case failure(String)
}

enum LoadingImageResult {
    case loading(Bool)
    case success(UIImage?)
    case failure(String)
}

enum ListPokemonTypeResult {
    case loading(Bool)
    case success([PokemonType])
    case failure(String)
}

protocol PokemonLoader {
    func getListPokemon(currentPage: Int, pageSize: Int, completion: @escaping (ListPokemonResult) -> ())
    func getListPokemonType(completion: @escaping (ListPokemonTypeResult) -> ())
}

class PokemonLoaderImpl : PokemonLoader {
    func getListPokemon(currentPage: Int = 1, pageSize: Int = 10, completion: @escaping (ListPokemonResult) -> ()) {
        let url = URL(string: "https://api.pokemontcg.io/v2/cards?page=\(currentPage)&pageSize=\(pageSize)")!
        
        completion(.loading(true))
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(.loading(false))
                guard let data = data else {
                    completion(.failure("Data not found"))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ListPokemonResponse.self, from: data)
                    let response = ObjectMapper().mapListPokemonResponseToListPokemonDomain(listPokemonResponse: result.data)
                    completion(.success(response))
                } catch {
                    completion(.failure("Failed to convert"))
                }
            }
        }.resume()
    }
    
    func getListPokemonType(completion: @escaping (ListPokemonTypeResult) -> ()) {
        let url = URL(string: "https://api.pokemontcg.io/v2/types")!
        
        completion(.loading(true))
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                completion(.loading(false))
                guard let data = data else {
                    completion(.failure("Data not found"))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ListPokemonTypeResponse.self, from: data)
                    let response = ObjectMapper().mapListPokemonTypeResponseToListPokemonTypeDomain(listPokemonTypeResponse: result)
                    completion(.success(response))
                } catch {
                    completion(.failure("Failed to convert"))
                }
            }
        }.resume()
    }
}
