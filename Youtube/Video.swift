//
//  Video.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/22/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation

class Video {

    //Main API Data Coming from the Youtube Api.
    private var name: String?
    private var id: String?
    private var description: String?
    private var thumbnailUrl: String?
    private var publishedDate: Date?
    private var channelTitle: String?
    
    //Data added later locally.
    private var isFavorite: Bool?
    private var isHistory: Bool?
    private var localUrl: String?
    private var saveDate: Date?
    
    
    //The init only initalize the core data coming from the youtube api
    init(_ name:String,_ id:String,_ description:String, _ thumbnailUrl: String, _ publishedDate: Date?, _ channelTitle: String) {
        self.name = name
        self.description = description
        self.id = id
        self.thumbnailUrl = thumbnailUrl
        self.publishedDate = publishedDate
        self.channelTitle = channelTitle
    }
    
    //Setters
    func setFavorite(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    func setHistory(_ isHistory: Bool) {
        self.isHistory = isHistory
    }
    
    func setLocalUrl(_ localUrl: String) {
        self.localUrl = localUrl
    }
    
    func setSaveDate(_ saveDate: Date?) {
        self.saveDate = saveDate
    }
    
    //Getters
    func isSavedAsFavorite() -> Bool {
      return isFavorite ?? false
    }
    
    func isSavedAsHistory() -> Bool {
      return isHistory ?? false
    }
    
    func getLocalUrl() -> String {
      return localUrl ?? ""
    }
    
    func getSaveDate() -> Date? {
      return saveDate
    }
    
    func getName() -> String? {
        return name
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func getId() -> String {
        return id ?? ""
    }
    
    func getThumbnailUrl() -> String? {
        return thumbnailUrl
    }
    
    func getPublishedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
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
