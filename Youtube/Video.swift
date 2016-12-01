//
//  Video.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/22/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation

class Video {

    private var name: String?
    private var id: String?
    private var description: String?
    private var thumbnailUrl: String?
    private var publishedDate: Date?
    private var channelTitle: String?
    
    init(_ name:String,_ id:String,_ description:String, _ thumbnailUrl: String, _ publishedDate: Date?, _ channelTitle: String) {
        self.name = name
        self.description = description
        self.id = id
        self.thumbnailUrl = thumbnailUrl
        self.publishedDate = publishedDate
        self.channelTitle = channelTitle
    }
    
    func getName() -> String? {
        return name
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func getId() -> String? {
        return id
    }
    
    func getThumbnailUrl() -> String? {
        return thumbnailUrl
    }
    
    func getPublishedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
//        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = publishedDate {
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    func getPublishedDateAsDate() -> Date? {
        return publishedDate
    }
    
    func getChannelTitle() -> String? {
        return channelTitle
    }
}
