//
//  YoutubeVideosTableViewDelegete.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 12/1/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation

/**
 * This delgate is response for delegating any action from the TableViewContorller to the interested controller.
 */
protocol YoutubeVideosTableViewDelegete {
    /**
     This method is invoked when an item from the tableView is deleted.
     */
    func removeVideoFromList(_ video: Video, _ isLastItem: Bool)
}
