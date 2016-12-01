//
//  CustomeNavigationViewController.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/25/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit

class CustomeNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = UIBarStyle.black
        self.navigationBar.barTintColor = UIColor.red
        self.navigationBar.tintColor = UIColor.white
//        self.navigationBar.backgroundColor = UIColor.red

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

}
