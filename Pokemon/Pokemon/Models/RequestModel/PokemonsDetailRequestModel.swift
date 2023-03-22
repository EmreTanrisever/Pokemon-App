//
//  PokemonsDetailRequestModel.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import Foundation

final class PokemonsDetailRequestModel: BaseRequestModel {
    
    static let shared = PokemonsDetailRequestModel()
    
    override var schema: String {
        Constants.NetworkConstant.pokemonSchema
    }
    
    override var host: String {
        Constants.NetworkConstant.pokemonHost
    }
    
    override var path: String {
        Constants.NetworkConstant.pokemonPath
    }
}
