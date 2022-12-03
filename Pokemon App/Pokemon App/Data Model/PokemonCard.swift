//
//  PokemonCard.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import Foundation
import UIKit

class PokemonCard {
    let id: String
    let imageURL: String
    var image: UIImage?
    
    init(id: String, imageURL: String, image: UIImage?) {
        self.id = id
        self.imageURL = imageURL
        self.image = image
    }
    
    func downloadImage() {
        let loader = ImageLoader()
        if let url = URL(string: imageURL) {
            loader.downloadImageWithURLSession(url: url) { result in
                switch result {
                case .success(let downloadedImage):
                    self.image = downloadedImage
                case .failure:
                    self.image = nil
                }
            }
        }
    }
    
    func cancelDownloadImage(){
        image = nil
    }
}
