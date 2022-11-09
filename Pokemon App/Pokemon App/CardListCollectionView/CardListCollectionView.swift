//
//  CardListCollectionView.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import UIKit

class CardListCollectionView: UICollectionView {
    
    var pokemonList: [PokemonCard] = []
    
}

// MARK: - UICollectionViewDataSource
extension CardListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        
        let pokemonCard = pokemonList[indexPath.row]
        
        cell.downloadImage(imageURL: pokemonCard.imageURL)
        
        
        return cell
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CardListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        let width = collectionViewSize/2
        return CGSize(width: width, height: width * 3 / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

// MARK: - UICollectionViewDelegate
extension CardListCollectionView: UICollectionViewDelegate {
}




