//
//  Pokemon Response.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 27/10/22.
//

import Foundation

// MARK: - List Pokemon Response
struct ListPokemonResponse: Codable {
    let data: [PokemonResponse]
    let page, pageSize, count, totalCount: Int
}

// MARK: - Pokemon Response
struct PokemonResponse: Codable {
    let id, name: String
    let images: PokemonResponseImages

    enum CodingKeys: String, CodingKey {
        case id, name
        case images
    }
}


// MARK: - PokemonResponseImages
struct PokemonResponseImages: Codable {
    let small, large: String
}
