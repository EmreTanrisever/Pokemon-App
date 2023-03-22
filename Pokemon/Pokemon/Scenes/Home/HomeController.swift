//
//  ViewController.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 20.03.2023.
//

import UIKit

protocol HomeControllerInterface: AnyObject {
    func configure()
    func prepareTableView()
    func reloadDataTableView()
}

final class HomeController: UIViewController, HomeControllerInterface {

    private let pokemonsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokemonsTableViewCell.self, forCellReuseIdentifier: PokemonsTableViewCell.identifier)
        tableView.rowHeight = 100
        return tableView
    }()
    
    private lazy var viewModel = HomeViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension HomeController {
    func configure() {
        view.addSubview(pokemonsTableView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func prepareTableView() {
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
    }
    
    func reloadDataTableView() {
        pokemonsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pokemonsTableView.dequeueReusableCell(
            withIdentifier: PokemonsTableViewCell.identifier,
            for: indexPath
        ) as? PokemonsTableViewCell else  {
            return UITableViewCell()
        }
        
        return cell
    }
}
