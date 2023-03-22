//
//  NetworkService.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 20.03.2023.
//

import Foundation

protocol NetworkServiceInterface {
    
    func fetchPokemons(completion: @escaping(Result<PokemonsResponse, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceInterface {
    
    func fetchPokemons(completion: @escaping(Result<PokemonsResponse, NetworkError>) -> Void) {
        guard let url = PokemonsRequestModel.shared.createURL(with: nil) else { return }
        NetworkManager.shared.sendRequest(urlRequest: url) { response in
            completion(response)
        }
    }
}
