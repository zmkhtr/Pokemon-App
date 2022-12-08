//
//  ImageLoader.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 24/11/22.
//
import Foundation
import UIKit

enum LoadingImageResult {
    case loading(Bool)
    case success(UIImage?)
    case failure
}

protocol ImageLoader {
    func getImageFromURL(url: URL, completion: @escaping (LoadingImageResult) -> ())
}

class ImageLoaderImpl: ImageLoader {
    private var downloadTask: URLSessionDataTask?
    
    func getImageFromURL(url: URL, completion: @escaping (LoadingImageResult) -> ()) {
        
        downloadTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, _ in
            guard let _ = self else { return }
            
            DispatchQueue.main.async {
                completion(.loading(true))
                
                if let data = data,
                   let response = response as? HTTPURLResponse,
                   response.statusCode == 200 {
                    completion(.loading(false))
                    
                    let image = UIImage(data: data)
                    completion(.success(image))
                    
                } else {
                    completion(.loading(false))
                    completion(.failure)
                    
                }
            }
        }
        
        downloadTask?.resume()
    }
    
    func cancelDownloadTask() {
        downloadTask?.suspend()
        downloadTask = nil
    }
}
