//
//  PokemonCollectionViewCell.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 24/10/22.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PokemonCollectionViewCell"
    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        UINib(nibName: "PokemonCollectionViewCell", bundle: nil)
    }
    
    func configure(with image: String) {
        guard let url = URL(string: image) else { return }
        
        pokemonImageView.loadFromUrl(url: url) { [weak self] result in
            switch result {
            case .loading(let isLoading):
                DispatchQueue.main.async {
                    self?.showShimmering(isLoading)
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.pokemonImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showShimmering(_ isLoading: Bool) {
        containerView.isShimmering = isLoading
        containerView.backgroundColor = isLoading ? .darkGray : .clear
    }
    
}
