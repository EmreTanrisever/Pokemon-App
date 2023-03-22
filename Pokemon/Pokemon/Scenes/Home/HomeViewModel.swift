//
//  HomeViewModel.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import Foundation
import UIKit

protocol HomeViewModelInterface {
    var view: HomeControllerInterface? { get }
    
    func viewDidLoad()
}

final class HomeViewModel {
    weak var view: HomeControllerInterface?
    
    init(_ view: HomeControllerInterface) {
        self.view = view
    }
}

extension HomeViewModel: HomeViewModelInterface {
    
    func viewDidLoad() {
        view?.configure()
        view?.prepareTableView()
    }
}
