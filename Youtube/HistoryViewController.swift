//
//  HistoryViewController.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/23/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController {
    
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var initialLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        videosList = CoreDataHelper.getVideosList(.History)
        if videosList.count > 0 {
            initialLabel.isHidden = true
            tableViewContainer.isHidden = false
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

extension HistoryViewController: YoutubeVideosTableViewDelegete {
    func removeVideoFromList(_ video: Video, _ isLastItem: Bool) {
        initialLabel.isHidden = !isLastItem
        tableViewContainer.isHidden = isLastItem
        _ = CoreDataHelper.removeVideo(video, .History)
    }
}
