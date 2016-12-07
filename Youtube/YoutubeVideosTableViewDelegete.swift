//
//  YoutubeVideosTableViewDelegete.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 12/1/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation

protocol YoutubeVideosTableViewDelegete {
    func removeVideoFromList(_ video: Video, _ isLastItem: Bool)
}
