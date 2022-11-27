//
//  FavoriteVC.swift
//  Pokemon App
//
//  Created by Mac Pro on 13/11/22.
//

import UIKit

class ViewControllers: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let CardListVC = CardListVC()
        let FavoriteVC = FavoriteVC()
        // Do any additional setup after loading the view.
        self.setViewControllers([CardListVC, FavoriteVC], animated: false)
        self.tabBar.tintColor = UIColor ( red: CGFloat(57/255.0), green: CGFloat(62/255.0), blue: CGFloat(70/255.0), alpha: CGFloat(1.0) )    }
    
}
class CardListVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: CGFloat(57/255.0), green: CGFloat(62/255.0), blue: CGFloat(70/255.0), alpha: CGFloat(1.0) )
    }
}
class FavoriteVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor( red: CGFloat(57/255.0), green: CGFloat(62/255.0), blue: CGFloat(70/255.0), alpha: CGFloat(1.0) )
        

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

