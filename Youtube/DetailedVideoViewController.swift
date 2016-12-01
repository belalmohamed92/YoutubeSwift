//
//  DetailedVideoViewController.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/28/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class DetailedVideoViewController: UIViewController, YTPlayerViewDelegate {

    var video: Video!
    let pVars = ["playsinline":1,"showinfo":0,"rel":1,"controls":1,"origin":"https://www.youtube.com","modestbranding":1] as [String : Any]
    
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if !sender.isSelected && CoreDataHelper.saveVideo(video, .Favorites) {
                sender.isSelected = true
            }else{
                _ = CoreDataHelper.removeVideo(video, .Favorites)
                sender.isSelected = false
            }
            
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtubePlayer.delegate = self
        loadViewsWithData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func loadViewsWithData(){
        youtubePlayer.load(withVideoId: video!.getId()!, playerVars: pVars)
        favoriteButton.isSelected = CoreDataHelper.isVideoExist(.Favorites, videoId: video.getId()!)
        videoTitle.text = video.getName() ?? ""
        channelTitle.text = video.getChannelTitle() ?? ""
        publishDate.text = video.getPublishedDate()
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        print("Player Is Ready")
    }

}
