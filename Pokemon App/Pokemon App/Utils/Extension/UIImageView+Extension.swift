//
//  UIImageView+Extension.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 27/10/22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFromUrl(url: URL, completion: @escaping (LoadingImageResult) -> ()) {
        completion(.loading(true))
        
        DispatchQueue.global().async { 
            do {
                let data = try Data(contentsOf: url)
                completion(.loading(false))
                completion(.success(UIImage(data: data) ?? nil))
            } catch {
                completion(.loading(false))
                completion(.failure(error.localizedDescription))
            }
        }
    }
}
