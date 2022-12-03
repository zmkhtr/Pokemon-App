//
//  CardListController.swift
//  Pokemon App
//
//  Created by Novan Agung Waskito on 12/11/22.
//

import Foundation
import UIKit

class CardListViewController: UIViewController {
    @IBOutlet var cardListSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSearchBar()
        }
    
    
    // Mark: UISearchBar
    
    func settingSearchBar() {
        let whiteColor = UIColor.white.withAlphaComponent(0.6)
        cardListSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [.foregroundColor: whiteColor])
        cardListSearchBar.searchTextField.textColor = .white
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(whiteColor, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setImage(image, for: .search, state: .normal)
        navigationItem.titleView = cardListSearchBar
        
    }
    
        
    }
    



