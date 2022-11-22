//
//  PokemonTypeCollectionViewCell.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import UIKit

class PokemonTypeCollectionViewCell: UICollectionViewCell {

    static let identifier = "PokemonTypeCollectionViewCell"
    
    @IBOutlet private weak var pokemonTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    static func nib() -> UINib {
        UINib(nibName: "PokemonTypeCollectionViewCell", bundle: nil)
    }
    
    func configure(type: String) {
        pokemonTypeLabel.text = type
    }
}
