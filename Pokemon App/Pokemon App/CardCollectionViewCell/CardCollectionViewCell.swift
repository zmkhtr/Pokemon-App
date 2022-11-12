//
//  CardCollectionViewCell.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var pokemonCardImageView: UIImageView!
    
    
    let imageLoader = ImageLoader()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func downloadImage(imageURL: String){
        if let url = URL(string: imageURL) {
            imageLoader.downloadImageWithURLSession(url: url) { result in
                switch result {
                case .success(let downloadedImage):
                    self.pokemonCardImageView.image = downloadedImage
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
    
}
