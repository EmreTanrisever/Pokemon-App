//
//  PokemonRequestModel.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 20.03.2023.
//

import Foundation

final class PokemonsRequestModel: BaseRequestModel {
    static let shared = PokemonsRequestModel()
    
    override var schema: String {
        Constants.NetworkConstant.pokemonSchema
    }
    
    override var host: String {
        Constants.NetworkConstant.pokemonHost
    }
    
    override var path: String {
        Constants.NetworkConstant.pokemonPath
    }
    
    override var queryItems: [String : Any] {
        [
            "offset": 0,
            "limit": 20
        ]
    }
    
}
