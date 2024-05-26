//
//  TabBarController.swift
//  TradingApp
//
//  Created by Vinod Gupta on 26/05/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View Controllers
        let portfolioVC = HomeViewController()
        let watchlistVC = UIViewController()
        let ordersVC = UIViewController()
        let fundsVC = UIViewController()
        let investVC = UIViewController()
        
        // Set titles and icons for the tab bar items
        portfolioVC.title = "Portfolio"
        portfolioVC.tabBarItem.image = UIImage(systemName: "briefcase.fill")

        watchlistVC.title = "Watchlist"
        watchlistVC.tabBarItem.image = UIImage(systemName: "star.fill")

        ordersVC.title = "Orders"
        ordersVC.tabBarItem.image = UIImage(systemName: "cart.fill")

        fundsVC.title = "Funds"
        fundsVC.tabBarItem.image = UIImage(systemName: "banknote.fill")

        investVC.title = "Invest"
        investVC.tabBarItem.image = UIImage(systemName: "arrow.up.arrow.down")

        // Set navigation controllers for each tab
        let portfolioNavVC = UINavigationController(rootViewController: portfolioVC)
        let watchlistNavVC = UINavigationController(rootViewController: watchlistVC)
        let ordersNavVC = UINavigationController(rootViewController: ordersVC)
        let fundsNavVC = UINavigationController(rootViewController: fundsVC)
        let investNavVC = UINavigationController(rootViewController: investVC)
        
        // Add view controllers to the tab bar
        viewControllers = [watchlistNavVC, ordersNavVC, portfolioNavVC, fundsNavVC, investNavVC]
        
        // Set the default selected tab
        selectedIndex = 2
    }
}
