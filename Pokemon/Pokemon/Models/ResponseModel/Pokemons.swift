//
//  Pokemon.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import Foundation

struct Pokemons: Codable {
    let next: String?
    let previous: String?
    let results: [PokemonResult]
}
