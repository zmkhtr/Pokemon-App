//
//  CustomTabBarController.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import UIKit

class CustomTabBarController: UITabBarController {

    let arrayOfImageNameForSelectedState = ["list-active", "favorite-active"]
    let arrayOfImageNameForUnselectedState = ["list-inactive", "favorite-inactive"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
                
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
}
