//
//  CategoryTypeCollectionViewCell.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 02/12/22.
//

import UIKit
enum CategoryTypeResult {
    case success
    case loading
    case failure
}

class CategoryTypeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pokemonTypeBackgroundView: UIView!
    
    @IBOutlet weak var typeLabel: UILabel!
    private var downloadTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        func settingTypeButton(text: String, selected: Bool) {
            pokemonTypeBackgroundView.layer.cornerRadius = 20;
            pokemonTypeBackgroundView.layer.masksToBounds = true;
            pokemonTypeBackgroundView.backgroundColor = selected ? UIColor(named: "ButtonColor") : UIColor(named: "PrimaryColor")
            typeLabel.text = text
            
        }
    }
