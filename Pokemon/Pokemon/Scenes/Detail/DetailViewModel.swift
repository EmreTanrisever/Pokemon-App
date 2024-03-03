//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 23.03.2023.
//

import Foundation

protocol DetailViewModelInterface {
    var view: DetailViewControllerInterface? { get set }
    var pokemonAbility: PokemonEffect? { get set }
    var pokemon: PokemonDetail? { get set }
    
    func viewDidLoad()
    func returnTypeCount(type: [Types])
    func getAbility(id: Int)
}

final class DetailViewModel {
    
    var view: DetailViewControllerInterface?
    private var service = NetworkService()
    var pokemonAbility: PokemonEffect?
    var pokemon: PokemonDetail?
    var collectionViewData: PokemonDetail?
    
    init(_ view: DetailViewControllerInterface) {
        self.view = view
    }
}

extension DetailViewModel: DetailViewModelInterface {
    
    func viewDidLoad() {
        view?.configure()
        view?.startAnimating()
    }
    
    func returnTypeCount(type: [Types]) {
        if type.count > 1 {
            view?.createTypesLabel(types: [type[0].type, type[1].type])
        } else {
            view?.createTypeLabel(type: type[0].type)
        }
    }
    
    func getAbility(id: Int) {
        service.fetchAbilityOfPokemon(id: id) { [weak self] response in
            switch response {
            case .success(let ability):
                DispatchQueue.main.async { [weak self] in
                    self?.pokemonAbility = ability.effect_entries[1]
                    self?.collectionViewData = self?.pokemon
                    self?.view?.reloadData()
                    self?.view?.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
