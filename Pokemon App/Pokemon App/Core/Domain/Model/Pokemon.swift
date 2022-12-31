//
//  Pokemon.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import Foundation
import UIKit

class Pokemon {
    let id: String
    let name: String
    let images: PokemonImages
    var image: UIImage?
    
    init(id: String, name: String, images: PokemonImages, image: UIImage?) {
        self.id = id
        self.name = name
        self.images = images
        self.image = image
    }
}

struct PokemonImages {
    let small, large: String
}

extension Pokemon {
    func getImageFromUrl() {
        let imageLoader = ImageLoaderImpl()
        guard let url = URL(string: images.small) else { return }
        
        imageLoader.getImageFromURL(url: url) { [weak self] result in
            switch result {
            case .loading(_):
                print("Do nothing!")
            case .success(let fetchedImage):
                self?.image = fetchedImage
            case .failure:
                self?.image = nil
            }
        }
    }
    
    func cancelDownloadingImage() {
        self.image = nil
    }
}
