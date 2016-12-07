//
//  YoutubeServices.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/24/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation
import Alamofire

class YoutubeServices {
    
    private static let apiKey = "AIzaSyA1VTC9rqm7B9tpL7I8wWgl2_pzK51lWsk"
    private static let baseUrl = "https://www.googleapis.com/youtube/v3/search"
    private static var part = "id,snippet" //Default, Developer will be able to change that.
    private static var maxResults = 50 //Default, Developer will be able to change that.
    private static var order = "viewCount" //Default, Developer will be able to change that.
    
    
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
                        closure(searchResponse.getVideosList()!)
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}
