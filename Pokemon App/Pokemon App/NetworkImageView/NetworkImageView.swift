//
//  NetworkImageView.swift
//  Pokemon App
//
//  Created by Nadia Darin on 25/10/22.
//

import UIKit

class NetworkImageView: UIView {
    
    var imageURL = "https://images.pokemontcg.io/swsh4/25_hires.png"
    let nibName = "NetworkImageView"
    var contentView: UIView?
    let loader = ImageLoader()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        downloadImage()
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func downloadImage(){
        startDownloadImage()
        loader.downloadImageWithURLSession(url: URL(string: imageURL)!) { result in
            switch result {
            case .success(let downloadedImage):
                self.successedDownloadImage(downloadedImage)
            case .failure:
                self.failedDownloadImage()
            }
        }
    }
    
    private func startDownloadImage(){
        imageView.isHidden = true
        errorLabel.isHidden = true
        retryButton.isHidden = true
        isShimmering = true
        backgroundColor = .gray
    }
    
    private func successedDownloadImage(_ img: UIImage) {
        imageView.isHidden = false
        imageView.image = img
        isShimmering = false
        backgroundColor = nil
    }
    
    private func failedDownloadImage(){
        print("Error")
        errorLabel.isHidden = true
        retryButton.isHidden = true
        isShimmering = false
        backgroundColor = nil
    }
    
}
