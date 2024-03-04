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
    var isPaging = false
    
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
        view?.startAnimating()
        getPokemons()
    }
    
    func getPokemons() {
        service.fetchPokemons { [weak self] response in
            self?.view?.startAnimating()
            switch response {
            case .success(let pokemons):
                DispatchQueue.main.async { [weak self] in
                    self?.pokemons.append(pokemons)
                    for item in pokemons.results {
                        self?.getDetailOfPokemon(name: item.name)
                    }
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
                DispatchQueue.main.async { [weak self] in
                    self?.pokemonsDetail.append(pokemonDetail)
                    self?.view?.reloadDataTableView()
                    self?.view?.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getNextPage(pagination: Bool) {
        if pagination {
            isPaging = true
        }
        guard let url = pokemons.last?.next else { return }
        service.fetchDetailOfPokemons(url: url) { [weak self] response in
            switch response {
            case .success(let pokemons):
                DispatchQueue.main.async { [weak self] in
                    self?.pokemons.append(pokemons)
                    for item in pokemons.results {
                        self?.getDetailOfPokemon(name: item.name)
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
            
        }
        if isPaging {
            isPaging = false
        }
    }
}
