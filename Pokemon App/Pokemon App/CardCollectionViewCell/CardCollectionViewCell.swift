//
//  CardCollectionViewCell.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var pokemonCardImageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorButton: UIButton!
    
    
    let imageLoader = ImageLoader()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpContainerAndError()
        
    }
    
    func downloadImage(imageURL: String){
        startDownloadImage()
        if let url = URL(string: imageURL) {
            imageLoader.downloadImageWithURLSession(url: url) { result in
                switch result {
                case .success(let downloadedImage):
                    self.successDownloadImage(downloadedImage)
                case .failure:
                    print("Error Downloading Image")
                }
            }
        }
    }
    
    func cancelDownloadImage(){
        imageLoader.cancelDownloadImage()
        DispatchQueue.main.async {
            self.pokemonCardImageView.image = nil
        }
    }
    
    private func setUpContainerAndError(){
        imageContainerView.layer.cornerRadius = 10
        imageContainerView.clipsToBounds = true
        errorButton.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .bold)
    }
    
    private func startDownloadImage(){
        imageContainerView.isShimmering = true
        imageContainerView.backgroundColor = .darkGray
        errorLabel.isHidden = true
        errorButton.isHidden = true
    }
    
    private func successDownloadImage(_ downloadedImage: UIImage){
        pokemonCardImageView.image = downloadedImage
        imageContainerView.isShimmering = false
        errorLabel.isHidden = true
        errorButton.isHidden = true
    }
    
    private func failedDownloadImage(){
        imageContainerView.isShimmering = false
        imageContainerView.backgroundColor = UIColor(named: "PrimaryColor")
        errorLabel.isHidden = false
        errorButton.isHidden = false
    }
    
}
