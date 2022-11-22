//
//  ListPokemonResponse.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import Foundation

struct ListPokemonResponse: Codable {
    let data: [PokemonResponse]
    let page, pageSize, count, totalCount: Int
}

struct PokemonResponse: Codable {
    let id, name: String
    let images: PokemonResponseImages

    enum CodingKeys: String, CodingKey {
        case id, name
        case images
    }
}

struct PokemonResponseImages: Codable {
    let small, large: String
}
