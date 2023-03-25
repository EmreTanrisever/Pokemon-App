//
//  PokemonsTableViewCell.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import UIKit
import Kingfisher

class PokemonsTableViewCell: UITableViewCell {
    static let identifier = "PokemonsTableViewCell"
 
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.systemGray6
        return imageView
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    private let pokemonOrderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.lightGray
        label.backgroundColor = UIColor.systemRed
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.textColor = UIColor.white
        return label
    }()
    
    private let pokemonWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.lightGray
        label.backgroundColor = UIColor.systemBlue
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.textColor = UIColor.white
        return label
    }()
    
    private let pokemonHeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.lightGray
        label.backgroundColor = UIColor.systemBlue
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.textColor = UIColor.white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configure()
    }
}

extension PokemonsTableViewCell {
    private func configure() {
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        contentView.addSubviews(pokemonImageView, pokemonNameLabel, pokemonOrderLabel, pokemonWeightLabel, pokemonHeightLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 100),
  
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 16),
            pokemonNameLabel.topAnchor.constraint(equalTo: pokemonImageView.topAnchor, constant: 8),
            
            pokemonOrderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pokemonOrderLabel.topAnchor.constraint(equalTo: pokemonNameLabel.topAnchor),
            
            pokemonWeightLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 16),
            pokemonWeightLabel.bottomAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: -8),
            
            pokemonHeightLabel.leadingAnchor.constraint(equalTo: pokemonWeightLabel.trailingAnchor, constant: 8),
            pokemonHeightLabel.topAnchor.constraint(equalTo: pokemonWeightLabel.topAnchor)
        ])
    }
}

extension PokemonsTableViewCell {
    func setData(pokemon: PokemonDetail) {
        guard let url = URL(string: pokemon.sprites.other.home.front_default) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.pokemonImageView.kf.setImage(with: url)
        }
        pokemonNameLabel.text = pokemon.name.uppercased()
        pokemonOrderLabel.text = "  #\(pokemon.order)  "
        pokemonWeightLabel.text = "  Weight: \(pokemon.weight)  "
        pokemonHeightLabel.text = "  Height: \(pokemon.height)  "
    }
}

