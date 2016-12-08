//
//  FavoritesViewController.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/23/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
}

extension FavoritesViewController: YoutubeVideosTableViewDelegete {
    func removeVideoFromList(_ video: Video, _ isLastItem: Bool){
        initialLabel.isHidden = !isLastItem
        tableViewContainer.isHidden = isLastItem
        _ =  CoreDataHelper.removeVideo(video, .Favorites)
    }
}
