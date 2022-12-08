//
//  PokemonCollectionViewCell.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PokemonCollectionViewCell"
    var onRetryButtonTapped : (() -> Void)?
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var errorStackView: UIStackView!
    
    private let imageLoader = ImageLoaderImpl()
    private var imageUrl = ""
    
    static func nib() -> UINib {
        UINib(nibName: "PokemonCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with image: String) {
        imageUrl = image
        downloadImage(imageURL: image)
    }
    
    func cancelDownloadImage() {
        pokemonImageView.image = nil
        imageLoader.cancelDownloadTask()
    }
    
    private func downloadImage(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        imageLoader.getImageFromURL(url: url) { [weak self] result in
            switch result {
            case .loading(let isLoading):
                self?.showShimmering(isLoading)
            case .success(let image):
                self?.pokemonImageView.image = image
                self?.showError(false)
            case .failure:
                self?.pokemonImageView.image = nil
                self?.showError(true)
            }
        }
    }
    
    private func showShimmering(_ isLoading: Bool) {
        containerView.isShimmering = isLoading
        containerView.backgroundColor = isLoading ? .darkGray : .clear
        pokemonImageView.isHidden = true
        errorStackView.isHidden = true
    }
    
    private func showError(_ isError: Bool = true) {
        pokemonImageView.isHidden = isError
        errorStackView.isHidden = !isError
    }
    
    @IBAction func onRetryButtonTapped(_ sender: Any) {
        downloadImage(imageURL: imageUrl)
    }
}
