//
//  AudioDownloadResponse.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 12/2/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation

class AudioDownloadResponse {
    
    private var title: String?
    private var length: String?
    private var link: String?
    
    
    init(_ title: String, _ length: String, _ link: String) {
        self.title = title
        self.length = length
        self.link = link
    }
    
    func getTitle() -> String {
       return title ?? ""
    }
    
    func getLength() -> String {
       return length ?? "0"
    }
    
    func getLink() -> String {
       return link ?? ""
    }
}
