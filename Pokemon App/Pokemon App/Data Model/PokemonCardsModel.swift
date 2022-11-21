//
//  PokemonModel.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 12/11/22.
//

import Foundation

struct PokemonCardsModel: Decodable {
    let pokemonCards: [PokemonCards]
}
struct PokemonCards: Decodable {
    let id: String
    let imageURL: String
    
    init(id: String, imageURL: String) {
        self.id = id
        self.imageURL = imageURL
    }
}

let sampleCard = PokemonCards(id: "pikachu", imageURL: "https://www.titancards.co.uk/image/data/blog/Jul_19/1_Pikachu_Card.jpg")


