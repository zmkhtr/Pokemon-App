//
//  ObjectMapper.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import Foundation

public final class ObjectMapper {
    static func mapListPokemonResponseToListPokemonDomain(listPokemonResponse: [PokemonResponse]) -> [Pokemon] {
        listPokemonResponse.map { response in
            Pokemon(
                id: response.id,
                name: response.name,
                images: PokemonImages(
                    small: response.images.small,
                    large: response.images.large
                ),
                image: nil
            )
        }
    }
    
    static func mapListPokemonTypeResponseToListPokemonTypeDomain(listPokemonTypeResponse: ListPokemonTypeResponse) -> [PokemonType] {
        listPokemonTypeResponse.data.map { type in
            PokemonType(title: type, isFavorite: false)
        }
    }
}
