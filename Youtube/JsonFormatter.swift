//
//  JsonFormatter.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/24/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation

class JsonFormatter {
    
    static func formatYouTubeJsonSearchResponse(_ jsonResponse: [String:Any]) -> SearchResponse {
        
        let pageInfo = jsonResponse["pageInfo"] as? [String: Any] ?? [:]
        let resultsPerPage = pageInfo["resultsPerPage"] as? Int ?? 0
        
        let totalResults = pageInfo["totalResults"] as? Int ?? 0
        let nextPageToken = jsonResponse["nextPageToken"] as? String ?? ""
        
        let items = jsonResponse["items"] as? [Any] ?? []
        var videos:[Video] = []
        
        for item in items  {
            let item = item as? [String:Any] ?? [:]
            let id = item["id"] as? [String:Any] ?? [:]
            let videoId = id["videoId"] as? String ?? ""
            let snippet = item["snippet"] as? [String:Any] ?? [:]
            let title = snippet["title"] as? String ?? ""
            let thumbnails = snippet["thumbnails"] as? [String:Any] ?? [:]
            let thumbnailHigh = thumbnails["high"] as? [String:Any] ?? [:]
            let thumbnailUrl = thumbnailHigh["url"] as? String ?? ""
            let description = snippet["description"] as? String ?? ""
            let publishedDateString = snippet["publishedAt"] as? String ?? ""
            let channelTitle = snippet["channelTitle"] as? String ?? ""
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
            let date = formatter.date(from: publishedDateString)
            
            
            
            videos.append(Video(title,videoId,description,thumbnailUrl,date,channelTitle))
        }
        
        return SearchResponse(videos,nextPageToken,resultsPerPage,totalResults)
    }
    
    static func formatYoutubeDownloadLinkResponse(_ jsonResponse: [String: Any]) -> AudioDownloadResponse {
        let link = jsonResponse["link"] as? String ?? ""
        let title = jsonResponse["title"] as? String ?? ""
        let length = jsonResponse["length"] as? String ?? ""
        
        return AudioDownloadResponse(title,length,link)
    }

}
