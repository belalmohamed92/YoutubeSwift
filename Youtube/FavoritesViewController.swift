//
//  FavoritesViewController.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/23/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController, YoutubeVideosTableViewDelegete{
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var tableViewContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        videosList = CoreDataHelper.getVideosList(.Favorites)
        
        if videosList.count > 0 {
            initialLabel.isHidden = true
            tableViewContainer.isHidden = false
        }else{
            initialLabel.isHidden = false
            tableViewContainer.isHidden = true
        }
    }
    
    func removeVideoFromList(_ video: Video, _ isLastItem: Bool) -> Bool {
        initialLabel.isHidden = !isLastItem
        tableViewContainer.isHidden = isLastItem
        return CoreDataHelper.removeVideo(video, .Favorites)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func cotrollerType() -> BaseViewController.ControllerType {
        return .FavoritesController
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
}