//
//  Types.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import Foundation

struct Types: Codable {
    let type: TypeOfPokemon
}

struct TypeOfPokemon: Codable {
    let name: String
}
