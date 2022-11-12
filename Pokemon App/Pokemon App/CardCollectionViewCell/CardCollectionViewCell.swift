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
    
    
    let imageLoader = ImageLoader()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpImageContainer()
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
    
    private func setUpImageContainer(){
        imageContainerView.layer.cornerRadius = 10
        imageContainerView.clipsToBounds = true
    }
    
    private func startDownloadImage(){
        imageContainerView.isShimmering = true
        imageContainerView.backgroundColor = .gray

    }
    
    private func successDownloadImage(_ downloadedImage: UIImage){
        pokemonCardImageView.image = downloadedImage
        imageContainerView.isShimmering = false
    }
    
    private func failedDownloadImage(){
        
    }
    
}
