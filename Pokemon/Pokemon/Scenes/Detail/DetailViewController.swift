//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 23.03.2023.
//

import UIKit
import Kingfisher

protocol DetailViewControllerInterface: AnyObject {
    
    func configure()
    func createTypeLabel(type: TypeOfPokemon)
    func createTypesLabel(types: [TypeOfPokemon])
    func reloadData()
    func startAnimating()
    func stopAnimating()
}

final class DetailViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.contentSize = (CGSize(width: 600, height: 800))
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let firstTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.systemBlue
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    private let secondTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.systemBlue
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    private let effectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.backgroundColor = UIColor.systemGray6
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var statsCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionViewLayout.itemSize = CGSize(width: 200, height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(StatsCollectionViewCell.self, forCellWithReuseIdentifier: StatsCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let shortEffectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.backgroundColor = UIColor.systemGray6
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .systemBlue
        return spinner
    }()
    
    private lazy var viewModel = DetailViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

// MARK: - ConfigureUI
extension DetailViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: view.frame.width),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pokemonImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 250),
            
            effectLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            effectLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 16),
            effectLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            statsCollectionView.topAnchor.constraint(equalTo: effectLabel.bottomAnchor, constant: 16),
            statsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            statsCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            shortEffectLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shortEffectLabel.topAnchor.constraint(equalTo: statsCollectionView.bottomAnchor, constant: 16),
            shortEffectLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension DetailViewController: DetailViewControllerInterface {
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        view.addSubview(spinner)
        scrollView.addSubview(contentView)
        contentView.addSubviews(pokemonImageView, effectLabel, statsCollectionView, shortEffectLabel)
        statsCollectionView.dataSource = self
        setConstraints()
    }
    
    func createTypeLabel(type: TypeOfPokemon) {
        view.addSubview(firstTypeLabel)
        
        firstTypeLabel.text = type.name.uppercased()
        firstTypeLabel.backgroundColor = UIColor(named: type.name)
        NSLayoutConstraint.activate([
            firstTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            firstTypeLabel.topAnchor.constraint(equalTo: shortEffectLabel.bottomAnchor, constant: 16),
            firstTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            firstTypeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func createTypesLabel(types: [TypeOfPokemon]) {
        view.addSubviews(firstTypeLabel, secondTypeLabel)
        let firstName = types[0].name
        let secondName = types[1].name
        
        firstTypeLabel.text = firstName.uppercased()
        secondTypeLabel.text = secondName.uppercased()
        firstTypeLabel.backgroundColor = UIColor(named: firstName)
        secondTypeLabel.backgroundColor = UIColor(named: secondName)
        
        NSLayoutConstraint.activate([
            firstTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            firstTypeLabel.topAnchor.constraint(equalTo: shortEffectLabel.bottomAnchor, constant: 16),
            firstTypeLabel.heightAnchor.constraint(equalToConstant: 40),
            firstTypeLabel.widthAnchor.constraint(equalToConstant: (view.frame.width / 2 - 24)),
            
            secondTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            secondTypeLabel.topAnchor.constraint(equalTo: shortEffectLabel.bottomAnchor, constant: 16),
            secondTypeLabel.heightAnchor.constraint(equalToConstant: 40),
            secondTypeLabel.widthAnchor.constraint(equalToConstant: (view.frame.width / 2 - 24))
        ])
    }
    
    func reloadData() {
        pokemonImageView.backgroundColor = UIColor.systemGray6
        
        if let pokemon = viewModel.pokemon {
            title = pokemon.name.uppercased()
            guard let url = URL(string: pokemon.sprites.other.home.front_default) else {
                return
            }
            DispatchQueue.main.async {
                self.pokemonImageView.kf.setImage(with: url)
            }
            DispatchQueue.main.async {
                self.statsCollectionView.reloadData()
            }
            viewModel.returnTypeCount(type: pokemon.types)
            guard let pokemonAbility = viewModel.pokemonAbility else { return }
            effectLabel.text = """
            \nEffect
            \(pokemonAbility.effect)\n
            """
            shortEffectLabel.text = """
            \(pokemonAbility.short_effect)
            """
        }
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
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let stats = viewModel.collectionViewData?.stats else { return 0 }
        return stats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let stats = viewModel.collectionViewData?.stats else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatsCollectionViewCell.identifier, for: indexPath) as? StatsCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(statName: "\(stats[indexPath.row].stat.name.uppercased())", baseStat: stats[indexPath.row].base_stat)
        return cell
    }
}

extension DetailViewController {
    func setData(pokemon: PokemonDetail) {
        viewModel.pokemon = pokemon
        viewModel.getAbility(id: pokemon.id)
    }
}
