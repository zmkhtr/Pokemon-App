//
//  RemotePokemonCard.swift
//  Pokemon App
//
//  Created by Nadia Darin on 06/11/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cardList = try? newJSONDecoder().decode(CardList.self, from: jsonData)

import Foundation

// MARK: - CardList
struct PokemonCardList: Codable {
    let data: [RemotePokemonCard]
    let page, pageSize, count, totalCount: Int
}

// MARK: - Datum
struct RemotePokemonCard: Codable {
    let id: String
    let name: String
    let images: CardImages
}

// MARK: - Ability
struct Ability: Codable {
    let name, text, type: String
}

// MARK: - Attack
struct Attack: Codable {
    let name: String
    let cost: [String]
    let convertedEnergyCost: Int
    let damage, text: String
}

// MARK: - Cardmarket
struct Cardmarket: Codable {
    let url: String
    let updatedAt: String
    let prices: [String: Double]
}

// MARK: - PokemonSet
struct PokemonSet: Codable {
    let id, name, series: String
    let printedTotal, total: Int
    let legalities: Legalities
    let ptcgoCode, releaseDate, updatedAt: String
    let images: SetImages
}

// MARK: - SetImages
struct SetImages: Codable {
    let symbol, logo: String
}

// MARK: - Legalities
struct Legalities: Codable {
    let unlimited: String
    let expanded: String?
}

// MARK: - CardImages
struct CardImages: Codable {
    let small, large: String
}

// MARK: - Resistance
struct Resistance: Codable {
    let type, value: String
}

// MARK: - Tcgplayer
struct Tcgplayer: Codable {
    let url: String
    let updatedAt: String
    let prices: Prices
}

// MARK: - Prices
struct Prices: Codable {
    let holofoil: Holofoil
    let reverseHolofoil: Holofoil?
}

// MARK: - Holofoil
struct Holofoil: Codable {
    let low, mid, high, market: Double
    let directLow: Double?
}

