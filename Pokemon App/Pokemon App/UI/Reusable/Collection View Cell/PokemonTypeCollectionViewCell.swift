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
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.shadowRadius = 8
    }

    static func nib() -> UINib {
        UINib(nibName: "PokemonTypeCollectionViewCell", bundle: nil)
    }
    
    func configure(type: PokemonType) {
        pokemonTypeLabel.text = type.title
        containerView.backgroundColor = type.isFavorite ? UIColor(named: "PokemonTypeSelectedCell") : UIColor(named: "TabBarBackgroundColor")
    }
}
