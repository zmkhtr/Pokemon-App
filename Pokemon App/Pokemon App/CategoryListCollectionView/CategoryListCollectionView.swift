//
//  CategoryListCollectionView.swift
//  Pokemon App
//
//  Created by Nadia Darin on 12/11/22.
//

import UIKit

class CategoryListCollectionView: UICollectionView {
    
    
    var categoryList: [String] = []
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
        
        return cell
        
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension CategoryListCollectionView: UICollectionViewDelegate {
}

