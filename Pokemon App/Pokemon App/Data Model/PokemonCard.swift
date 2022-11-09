//
//  PokemonCard.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import Foundation
import UIKit

class PokemonCard {
    let id: String
    let imageURL: String
    
    init(id: String, imageURL: String) {
        self.id = id
        
        self.imageURL = imageURL
    }
}

let fakePokemonCard = PokemonCard(id: "123" , imageURL: "https://images.pokemontcg.io/swsh4/25_hires.png")
