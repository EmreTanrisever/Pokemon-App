//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let height: Int
    let name: String
    let order: Int
    let sprites: Sprites
    let stats: [Stats]
    let types: [Types]
    let weight: Int
}
