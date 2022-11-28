//
//  CardListCollectionViewController.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 28/11/22.
//

import Foundation
import UIKit

class CardListCollectionViewController: UICollectionView {
    
}
//MARK: Layout for UICollectionView for resized the UIImageView
extension  CardListCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.0, height: 240.0)
    }
    
        //need properties to determine layout of collectionView such as minimumLineSpacing, minimumInteritemSpacing, itemSize, headerReferenceSize, footerReferenceSize, sectionInset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
        
    }
    
}

