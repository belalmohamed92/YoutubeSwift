//
//  AudioDownloadServices.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 12/2/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation
import Alamofire

/**
 * This class is a service class and it's responsiblity is to deal with anything related to the api responsible for the audio download.
 * https://www.youtubeinmp3.com/api/
 */
class AudoioDownloadServices {
    
    private static let format = "JSON"
    private static let videoUrl = "https://www.youtube.com/watch?v="
    private static let baseUrl = "https://www.youtubeinmp3.com/fetch?"
    
    /**
     * This method is responsible for downlaoding the audio of a specific youtube video and saving the audio in the suggested download destination.
     *
     * @param videoId is the id of the video that it's audio is requested.
     * @param closure is a Closure that is invoked when the audio is downloaded and the local Url is available, it takes the audioLink as param.
     * @param progressClousre is a Closure that gives the progress of the audio download it takes the progress value as a param.
     */
    static func fetchDownloadLink(_ videoId: String,_ closure:@escaping ( _ audioLink: URL?) -> Void,_ progressClosure:@escaping ( _ progress: Double) -> Void) {
        let params: Parameters = ["format":format, "video":videoUrl+videoId]
        print("init Request")
        Alamofire.request(baseUrl,parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    if let json = response.result.value as? [String:Any] {
                       downloadAudio(JsonFormatter.formatYoutubeDownloadLinkResponse(json).getLink(),closure,progressClosure)
                    }
                    break
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    private static func downloadAudio(_ link: String,_ closure:@escaping ( _ audio: URL?) -> Void, _ progressClosure:@escaping ( _ progress: Double) -> Void)  {
        let destination = DownloadRequest.suggestedDownloadDestination()
        
        Alamofire.download(link,to: destination).response { (response) in
            let urlString = response.destinationURL?.absoluteString ?? ""
            if urlString.contains(".mp3") {
                closure(response.destinationURL)
            }else{
                closure(nil)
            }
           
        }.downloadProgress { (progress) in
            progressClosure(progress.fractionCompleted)
        }
    }
}
