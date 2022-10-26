//
//  ObjectMapper.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 27/10/22.
//

import Foundation

class ObjectMapper {
    func mapListPokemonResponseToListPokemonDomain(listPokemonResponse: [PokemonResponse]) -> [Pokemon] {
        listPokemonResponse.map { response in
            Pokemon(
                id: response.id,
                name: response.name,
                images: PokemonImages(
                    small: response.images.small,
                    large: response.images.large
                )
            )
        }
    }
}
