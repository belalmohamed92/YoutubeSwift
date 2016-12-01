//
//  CustomTabBarViewController.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/25/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    let tabPosition = [0:"Search", 1:"Favorites", 2:"History"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.red
        self.title = tabPosition[0] ?? "Youtube"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        title = tabPosition[item.tag] ?? "Youtube"
    }
    
}
