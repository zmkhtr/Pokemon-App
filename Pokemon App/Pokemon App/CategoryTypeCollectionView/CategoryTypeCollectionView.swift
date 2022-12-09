//
//  CategoryTypeCollectionView.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 02/12/22.
//

import Foundation
import UIKit

class CategoryTypeCollectionView: UICollectionView {
    var categoryTypes : [String] = []
    var selectedType : String = " "
}

//MARK: CollectionView data source and delegate

extension CategoryTypeCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categoryTypes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryTypeCollectionViewCell", for:indexPath) as! CategoryTypeCollectionViewCell
        cell.settingTypeButton(text: category, selected: category == selectedType)
        return cell
    }
}
   
