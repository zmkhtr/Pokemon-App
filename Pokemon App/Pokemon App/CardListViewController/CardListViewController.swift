//
//  CardListViewController.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import UIKit

class CardListViewController: UIViewController {

    @IBOutlet var cardListSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
    }
    
    private func setUpSearchBar(){
        let whiteColor = UIColor.white.withAlphaComponent(0.6)
        
        cardListSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: whiteColor]
        )
        
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(whiteColor, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setImage(image, for: .search, state: .normal)
        
        navigationItem.titleView = cardListSearchBar
    }
}
