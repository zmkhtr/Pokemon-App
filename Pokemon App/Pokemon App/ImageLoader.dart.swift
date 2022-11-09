//
//  ImageLoader.dart.swift
//  Pokemon App
//
//  Created by Nadia Darin on 09/11/22.
//

import Foundation
import UIKit
import MapKit


enum ImageResult {
    case success(UIImage)
    case failure
}

class ImageLoader {
    
    func downloadImageWithURLSession(url: URL, completion: @escaping (ImageResult) -> Void) {
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure)
                
            } else {
                guard let _ = response as? HTTPURLResponse else {
                    completion(.failure)
                    return
                }
                
                guard let imageData = data else {
                    completion(.failure)
                    return
                }
                
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.sync {
                        completion(.success(image))
                    }
                } else {
                    completion(.failure)
                }
            }
        }.resume()
    }
}
