//
//  NetworkImageView.swift
//  Pokemon App
//
//  Created by Nadia Darin on 25/10/22.
//

import UIKit

class NetworkImageView: UIView {
    
    var imageURL = ""
    let nibName = "NetworkImageView"
    private var contentView: UIView?
    let loader = ImageLoader()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    @IBAction func onTapRetryButton(_ sender: UIButton) {
        downloadImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        downloadImage()
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    private func downloadImage(){
        startDownloadImage()
        if let url = URL(string: imageURL) {
            loader.downloadImageWithURLSession(url: url) { result in
                switch result {
                case .success(let downloadedImage):
                    self.successedDownloadImage(downloadedImage)
                case .failure:
                    self.failedDownloadImage()
                }
            }
        } else {
            failedDownloadImage()
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
        errorLabel.isHidden = false
        retryButton.titleLabel?.text = nil
        retryButton.isHidden = false
        isShimmering = false
    }
}
