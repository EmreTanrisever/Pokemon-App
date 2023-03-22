//
//  Sprites.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import Foundation

struct Sprites: Codable {
    let other: Other
}

struct Other: Codable {
    let dream_world: DreamWorldDetail
    let home: HomeDetail
}

struct DreamWorldDetail: Codable {
    let front_default: String
}

struct HomeDetail: Codable {
    let front_default: String
    let front_shiny: String
}

