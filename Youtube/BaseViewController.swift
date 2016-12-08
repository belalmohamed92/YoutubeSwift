//
//  BaseViewController.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/23/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var videosListTableViewController: VideosTableViewController?
    
    var videosList: [Video] = [] {
        didSet{
            videosListTableViewController?.setVideosList(videosList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VideosEmbededList"{
            videosListTableViewController = segue.destination as? VideosTableViewController
            videosListTableViewController?.delegate = self as? YoutubeVideosTableViewDelegete
        }
    }
    func setYoutubeVideoDelegate(_ delegate: YoutubeVideosTableViewDelegete) {
      videosListTableViewController?.delegate = delegate
    }
}

