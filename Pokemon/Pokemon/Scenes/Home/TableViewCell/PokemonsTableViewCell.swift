//
//  PokemonsTableViewCell.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import UIKit

class PokemonsTableViewCell: UITableViewCell {
    static let identifier = "PokemonsTableViewCell"
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func layoutSubviews() {

    }
}
