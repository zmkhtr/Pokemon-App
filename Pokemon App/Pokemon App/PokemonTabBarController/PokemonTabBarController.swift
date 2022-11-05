//
//  TabBarController.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import UIKit

class PokemonTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor(hexaString: "#222831")
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white
        
    }


}
