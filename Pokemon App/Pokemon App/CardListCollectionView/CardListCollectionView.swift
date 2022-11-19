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
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pokemonCard = pokemonList[indexPath.row]
        let cell = cell as! CardCollectionViewCell
        if let image = pokemonCard.image {
            cell.pokemonCardImageView.image = image
        } else {
            cell.pokemonImageURL = pokemonCard.imageURL
            cell.downloadImage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CardCollectionViewCell
        cell.cancelDownloadImage()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CardListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  30
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

// MARK: - UICollectionViewDelegate
extension CardListCollectionView: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSourcePrefetching
extension CardListCollectionView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            let pokemon = pokemonList[index.row]
            if let _ = pokemon.image {
                return
            }
            pokemon.downloadImage()
        }
    }
    
    func col_ew(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            let pokemon = pokemonList[index.row]
            if let _ = pokemon.image {
                pokemon.cancelDownloadImage()
            }
        }
    }
    
}




