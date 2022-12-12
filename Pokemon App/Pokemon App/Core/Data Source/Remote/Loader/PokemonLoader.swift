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

enum ListPokemonTypeResult {
    case loading(Bool)
    case success([PokemonType])
    case failure(String)
}

protocol PokemonLoader {
    func getListPokemon(currentPage: Int, pageSize: Int, completion: @escaping (ListPokemonResult) -> ())
    func getListPokemonType(completion: @escaping (ListPokemonTypeResult) -> ())
    func getSearchedPokemon(name: String, completion: @escaping (ListPokemonResult) -> ())
    func getPokemonsByType(currentPage: Int, pageSize: Int, type: String, name: String?, completion: @escaping (ListPokemonResult) -> ())
}

class PokemonLoaderImpl : PokemonLoader {
    func getListPokemon(currentPage: Int = 1, pageSize: Int = 10, completion: @escaping (ListPokemonResult) -> ()) {
        let urlQueryItems  = [
            URLQueryItem(name: "currentPage", value: "\(currentPage)"),
            URLQueryItem(name: "pageSize", value: "\(pageSize)")
        ]
        var urlComponent = URLComponents(string: "https://api.pokemontcg.io/v2/cards")!
        urlComponent.queryItems = urlQueryItems
        let url = urlComponent.url!
        
        completion(.loading(true))
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let _ = self else { return }
            
            DispatchQueue.main.async {
                completion(.loading(false))
                
                do {
                    if let data = data,
                       let response = response as? HTTPURLResponse,
                       response.statusCode == 200 {
                        let result = try JSONDecoder().decode(ListPokemonResponse.self, from: data)
                        let response = ObjectMapper.mapListPokemonResponseToListPokemonDomain(listPokemonResponse: result.data)
                        completion(.success(response))
                    } else {
                        completion(.failure("Unexpected Data"))
                    }
                } catch let error {
                    completion(.failure(error.localizedDescription))
                }
            }
        }.resume()
    }
    
    func getListPokemonType(completion: @escaping (ListPokemonTypeResult) -> ()) {
        let url = URL(string: "https://api.pokemontcg.io/v2/types")!
        
        completion(.loading(true))
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self else { return }
            
            DispatchQueue.main.async {
                completion(.loading(false))
                
                do {
                    if let data = data,
                       let response = response as? HTTPURLResponse,
                       response.statusCode == 200 {
                        let result = try JSONDecoder().decode(ListPokemonTypeResponse.self, from: data)
                        let response = ObjectMapper.mapListPokemonTypeResponseToListPokemonTypeDomain(listPokemonTypeResponse: result)
                        completion(.success(response))
                    } else {
                        completion(.failure("Unexpected Data"))
                    }
                } catch let error {
                    completion(.failure(error.localizedDescription))
                }
            }
        }.resume()
    }
    
    func getSearchedPokemon(name: String, completion: @escaping (ListPokemonResult) -> ()) {
        let urlQueryItems = [
            URLQueryItem(name: "currentPage", value: "\(1)"),
            URLQueryItem(name: "pageSize", value: "\(10)"),
            URLQueryItem(name: "q", value: "!name:\(name)"),
        ]
        var urlComponent = URLComponents(string: "https://api.pokemontcg.io/v2/cards")!
        urlComponent.queryItems = urlQueryItems
        
        let url = urlComponent.url!
        
        completion(.loading(true))
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self else { return }
            
            DispatchQueue.main.async {
                completion(.loading(false))
                
                do {
                  if let data = data,
                     let response = response as? HTTPURLResponse,
                     response.statusCode == 200 {
                      let result = try JSONDecoder().decode(ListPokemonResponse.self, from: data)
                      let response = ObjectMapper.mapListPokemonResponseToListPokemonDomain(listPokemonResponse: result.data)
                      completion(.success(response))
                  } else {
                      completion(.failure("Unexpected Data"))
                  }
                } catch let error {
                    completion(.failure(error.localizedDescription))
                }
            }
        }.resume()
    }
    
    func getPokemonsByType(currentPage: Int = 1,
                           pageSize: Int = 10,
                           type: String,
                           name: String? = nil,
                           completion: @escaping (ListPokemonResult) -> ()
    ) {
        var optionalQueryItem: URLQueryItem
        
        if let name = name, !name.isEmpty {
            optionalQueryItem = URLQueryItem(name: "q", value: "!name:\(name) types:\(type)")
        } else {
            optionalQueryItem = URLQueryItem(name: "q", value: "!types:\(type)")
        }
        let urlQueryItems  = [
            URLQueryItem(name: "currentPage", value: "\(currentPage)"),
            URLQueryItem(name: "pageSize", value: "\(pageSize)"),
            optionalQueryItem
        ]
        var urlComponent = URLComponents(string: "https://api.pokemontcg.io/v2/cards")!
        urlComponent.queryItems = urlQueryItems
        let url = urlComponent.url!
        
        completion(.loading(true))
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self else { return }
            
            DispatchQueue.main.async {
                completion(.loading(false))
                
                do {
                    if let data = data,
                       let response = response as? HTTPURLResponse,
                       response.statusCode == 200 {
                        let result = try JSONDecoder().decode(ListPokemonResponse.self, from: data)
                        let response = ObjectMapper.mapListPokemonResponseToListPokemonDomain(listPokemonResponse: result.data)
                        completion(.success(response))
                    } else {
                        completion(.failure("Unexpected Data"))
                    }
                } catch let error {
                    completion(.failure(error.localizedDescription))
                }
            }
        }.resume()
    }
}
