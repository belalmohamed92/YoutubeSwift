//
//  YoutubeServices.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/24/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation
import Alamofire

/**
 This class is a service class and it's responsiblity is to deal with anything related to the Youtube api
 */
class YoutubeServices {
    
    private static let apiKey = "AIzaSyA1VTC9rqm7B9tpL7I8wWgl2_pzK51lWsk"
    private static let baseUrl = "https://www.googleapis.com/youtube/v3/search"
    private static var part = "id,snippet" //Default, Developer will be able to change that.
    private static var maxResults = 50 //Default, Developer will be able to change that.
    private static var order = "viewCount" //Default, Developer will be able to change that.
    
    
    /**
     * This method is responsible for searching youtube for videos list with a specific search query.
     *
     * @param searchQuery String tpye holding the search note: it does't need to be encoded the Alamofire already handles that.
     * @param closure is a Closure that is invoked when the response has returned holding the list of videos, 
     *        The closure takes [Video] as a param. [Video] could be empty([]) if the api return empty list.
     */
    static func searchVideos(_ searchQuery: String,_ closure:@escaping (_ vid:[Video]) -> Void){
        let params:Parameters = ["part":part,"maxResults":maxResults,"key":apiKey,"q":searchQuery,"type":"video","order":order]
        Alamofire.request(baseUrl, parameters: params)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    if let json = response.result.value as? [String:Any] {
                        let searchResponse = JsonFormatter.formatYouTubeJsonSearchResponse(json)
                        closure(searchResponse.getVideosList() ?? [])
                    }else {
                        closure([])
                    }
                case .failure(let error):
                    //The Application does not handling errors yet.
                    print(error)
                }
        }
    }
}
