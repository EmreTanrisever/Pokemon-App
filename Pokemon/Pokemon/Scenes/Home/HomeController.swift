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
    func startAnimating()
    func stopAnimating()
}

final class HomeController: UIViewController {

    private let pokemonsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokemonsTableViewCell.self, forCellReuseIdentifier: PokemonsTableViewCell.identifier)
        tableView.rowHeight = 80
        return tableView
    }()
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var viewModel = HomeViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension HomeController: HomeControllerInterface {
    
    func configure() {
        
        title = "Pokemons"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(pokemonsTableView)
        view.addSubview(spinner)
        
        setConstraints()
    }
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    func prepareTableView() {
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
    }
    
    func reloadDataTableView() {
        self.pokemonsTableView.reloadData()
    }
}

extension HomeController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension HomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonsDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pokemonsTableView.dequeueReusableCell(
            withIdentifier: PokemonsTableViewCell.identifier,
            for: indexPath
        ) as? PokemonsTableViewCell else  {
            return UITableViewCell()
        }
        cell.setData(pokemon: viewModel.pokemonsDetail[indexPath.row])
        return cell
    }
}

extension HomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailViewController()
        controller.setData(pokemon: viewModel.pokemonsDetail[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > self.pokemonsTableView.contentSize.height - 700 {
            self.viewModel.getNextPage(pagination: true)
        }
    }
}
