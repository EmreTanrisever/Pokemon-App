//
//  NetworkService.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 20.03.2023.
//

import Foundation

protocol NetworkServiceInterface {
    
    func fetchPokemons(completion: @escaping(Result<PokemonsResponse, NetworkError>) -> Void)
    func fetchDetailOfPokemons(name: String, completion: @escaping(Result<PokemonDetail, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceInterface {
    
    func fetchPokemons(completion: @escaping(Result<PokemonsResponse, NetworkError>) -> Void) {
        guard let url = PokemonsRequestModel.shared.createURL(with: nil) else { return }
        NetworkManager.shared.sendRequest(urlRequest: url) { response in
            completion(response)
        }
    }
    
    func fetchDetailOfPokemons(name: String, completion: @escaping(Result<PokemonDetail, NetworkError>) -> Void) {
        guard let url = PokemonsDetailRequestModel.shared.createURL(with: name) else { return }
        NetworkManager.shared.sendRequest(urlRequest: url) { response in
            completion(response)
        }
    }
}
