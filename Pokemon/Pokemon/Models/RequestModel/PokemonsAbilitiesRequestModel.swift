//
//  PokemonsAbilitiesRequestModel.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 23.03.2023.
//

import Foundation

final class PokemonsAbilitiesRequestModel: BaseRequestModel {
    
    static let shared = PokemonsAbilitiesRequestModel()
    
    override var schema: String {
        Constants.NetworkConstant.pokemonSchema
    }
    
    override var host: String {
        Constants.NetworkConstant.pokemonHost
    }
    
    override var path: String {
        Constants.NetworkConstant.abilityPath
    }
}
