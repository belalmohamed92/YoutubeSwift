//
//  SearchResponse.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/24/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation

class SearchResponse {
    
    var videos: [Video]?
    var nextPageToken: String?
    var resultsPerPage: Int?
    var totalResults: Int?
    
    init(_ videos: [Video], _ nextPageToken:String, _ resultsPerPage: Int, _ totalResults: Int) {
        self.videos = videos
        self.nextPageToken = nextPageToken
        self.resultsPerPage = resultsPerPage
        self.totalResults = totalResults
    }
    
    func getVideosList() -> [Video]?{
        return videos
    }
    
    func getNextPageToken() -> String? {
        return nextPageToken
    }
    
    func getResultsPerPage() -> Int? {
        return resultsPerPage
    }
    
    func getTotalResults() -> Int? {
        return totalResults
    }
}
