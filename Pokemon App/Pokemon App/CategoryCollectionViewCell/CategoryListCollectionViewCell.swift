//
//  CategoryListCollectionView.swift
//  Pokemon App
//
//  Created by Nadia Darin on 12/11/22.
//

import UIKit

class CategoryListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryBackgroundView: UIView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpButton(text: String, selected: Bool) {
        categoryBackgroundView.layer.cornerRadius = 10;
        categoryBackgroundView.layer.masksToBounds = true;
        categoryBackgroundView.backgroundColor = selected ? UIColor(named: "ButtonColors") : UIColor(named: "PrimaryColor")
        categoryLabel.text = text
    }

}
