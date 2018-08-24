//
//  MainTabBarController.swift
//  MLife
//
//  Created by Yi Zheng on 2018-06-17.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        
    }
    
    func setupTabBarController(){
        tabBar.tintColor = .black
        
        let homeController = templateNavController(tabBarImage: #imageLiteral(resourceName: "home-30"), rootViewController: HomeDatasourceController())
        
        let searchController = templateNavController(tabBarImage: #imageLiteral(resourceName: "search-30"), rootViewController: SearchDatasourceController())
        
        let addController = templateNavController(tabBarImage: #imageLiteral(resourceName: "add-30"))
        
        let likedController = templateNavController(tabBarImage: #imageLiteral(resourceName: "heart-30"))
        
        let meController = templateNavController(tabBarImage: #imageLiteral(resourceName: "customer-30"), rootViewController: UserProfileController())
        
        viewControllers = [homeController, searchController, addController, likedController, meController]
        
        guard let items = tabBar.items else {return}
        
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        }
    }
    
    fileprivate func templateNavController(tabBarImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = tabBarImage
        return navController
    }
}
