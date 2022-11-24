//
//  PokemonLoader.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import Foundation

enum ListPokemonResult {
    case loading(Bool)
    case success([Pokemon])
    case failure(String)
}

protocol PokemonLoader {
    func getListPokemon(currentPage: Int, pageSize: Int, completion: @escaping (ListPokemonResult) -> ())
}

class PokemonLoaderImpl: PokemonLoader {
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
            guard let self = self else { return }
            
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
