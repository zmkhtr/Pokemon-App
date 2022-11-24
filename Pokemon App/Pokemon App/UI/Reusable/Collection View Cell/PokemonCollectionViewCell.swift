//
//  PokemonCollectionViewCell.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PokemonCollectionViewCell"
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var pokemonImageView: UIImageView!
    
    private let imageLoader = ImageLoaderImpl()
    
    static func nib() -> UINib {
        UINib(nibName: "PokemonCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with image: String) {
        guard let url = URL(string: image) else { return }
        
        imageLoader.getImageFromURL(url: url) { [weak self] result in
            switch result {
            case .loading(let isLoading):
                
                self?.showShimmering(isLoading)
            case .success(let image):
                self?.pokemonImageView.image = image
            case .failure:
                self?.pokemonImageView.image = nil
            }
        }
    }
    
    private func showShimmering(_ isLoading: Bool) {
        containerView.isShimmering = isLoading
        containerView.backgroundColor = isLoading ? .darkGray : .clear
    }
}
