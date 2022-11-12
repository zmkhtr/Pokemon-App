//
//  CategoryListCollectionView.swift
//  Pokemon App
//
//  Created by Nadia Darin on 12/11/22.
//

import UIKit

class CategoryListCollectionView: UICollectionView {
    
    
    var categoryList: [String] = ["Category lalallala", "Category 2", "Category 3", "Category 4", "Category 5", "Category 6", "Category 7", "Category 8"]
    var selectedCategory: String = ""
    
}


// MARK: - UICollectionViewDataSource
extension CategoryListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categoryList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
       
        
        cell.setUpButton(text: category, selected: category == selectedCategory)
        
//        cell.downloadImage(imageURL: pokemonCard.imageURL)
        
        
        return cell
        
    }
    
    
}

//// MARK: - UICollectionViewDelegateFlowLayout
//extension CategoryListCollectionView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        let padding: CGFloat =  10
//        let collectionViewSize = collectionView.frame.size.width - padding
//        let width = collectionViewSize/2
//        return CGSize(width: width, height: width * 3 / 2)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 15
//    }
//}
//
// MARK: - UICollectionViewDelegate
extension CategoryListCollectionView: UICollectionViewDelegate {
}

