//
//  StatsCollectionViewCell.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 23.03.2023.
//

import UIKit

final class StatsCollectionViewCell: UICollectionViewCell {
    static let identifier = "StatsCollectionViewCell"

    private let statLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Content view kısmı yani ekleme kısmı buraya gelecek.
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 8
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
}

extension StatsCollectionViewCell {
    func configure() {
        contentView.addSubview(statLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            statLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            statLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}

extension StatsCollectionViewCell {

    func setData(statName: String, baseStat: Int) {
        statLabel.text = "\(statName): \(baseStat)"
    }
}
