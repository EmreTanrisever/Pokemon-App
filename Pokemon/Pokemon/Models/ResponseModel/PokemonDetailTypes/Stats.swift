//
//  Stats.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import Foundation

struct Stats: Codable {
    let base_stat: Int
    let stat: Stat
}

struct Stat: Codable {
    let name: String
}
