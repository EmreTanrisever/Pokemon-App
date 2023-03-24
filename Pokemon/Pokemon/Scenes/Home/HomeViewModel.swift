//
//  HomeViewModel.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import Foundation
import UIKit

protocol HomeViewModelInterface {
    
    var view: HomeControllerInterface? { get set}
    var pokemons: [PokemonsResponse] { get set }
    var pokemonsDetail: [PokemonDetail] { get set }
    
    func viewDidLoad()
    func getPokemons()
    func getDetailOfPokemon(name: String)
}

final class HomeViewModel {
    
    weak var view: HomeControllerInterface?
    private let service = NetworkService()
    
    var pokemons: [PokemonsResponse] = []
    var pokemonsDetail: [PokemonDetail] = []
    
    init(_ view: HomeControllerInterface) {
        self.view = view
    }
}

extension HomeViewModel: HomeViewModelInterface {
    
    func viewDidLoad() {
        view?.configure()
        view?.prepareTableView()
        getPokemons()
    }
    
    func getPokemons() {
        service.fetchPokemons { [weak self] response in
            switch response {
            case .success(let pokemons):
                self?.pokemons.append(pokemons)
                for item in pokemons.results {
                    self?.getDetailOfPokemon(name: item.name)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getDetailOfPokemon(name: String) {
        service.fetchDetailOfPokemons(name: name) { [weak self] response in
            switch response {
            case .success(let pokemonDetail):
                self?.pokemonsDetail.append(pokemonDetail)
                self?.view?.reloadDataTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
 
}
