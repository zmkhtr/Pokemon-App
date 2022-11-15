//
//  CardListController.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 12/11/22.
//

import Foundation
import UIKit

class CardListViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var cardListCollectionView: UICollectionView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        
        }
        
    }
    
//MARK: Search Bar
    
    let searchController = UISearchController()



