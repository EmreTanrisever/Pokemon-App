//
//  PokemonAbility.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 23.03.2023.
//

import Foundation

struct PokemonAbility: Codable {
    let effect_entries: [PokemonEffect]
}

struct PokemonEffect: Codable {
    let effect: String
    let language: PokemonLanguage
    let short_effect: String
}

struct PokemonLanguage: Codable {
    let name: String
}
