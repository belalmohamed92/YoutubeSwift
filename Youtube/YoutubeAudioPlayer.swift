//
//  YoutubeAudioPlayer.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 12/5/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit
import AVFoundation


/**
 * This delegate is responsible for delegating the audio actions to the interested controller.
 */
@objc protocol YoutubeAudioDelegate: NSObjectProtocol {
    /**
     This Method is invoked when the AVAudioPlayer stops.
     */
    @objc optional func audioDidStop()
    /**
     This Method is invoked when the AVAudioPlayer Starts playing.
     */
    @objc optional func audioDidPlay()
    /**
     This Method is invoked when the AVAudioPlayer finished playing.
     */
    @objc optional func audioEnded()
}

@IBDesignable
class YoutubeAudioPlayer: UIView {
    
    var contentView : UIView!
    var player: AVAudioPlayer?
    var progressUpdater: CADisplayLink?
    var audioDuration: TimeInterval?
    var delegate: YoutubeAudioDelegate?

    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var audioProgress: UIProgressView!
    
    @IBAction func play(_ sender: UIButton) {
        if let audioPlayer = player {
            if audioPlayer.isPlaying {
                stopAudio()
            }else {
                playAudio()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    /**
      * This method is responsible for setting the audio url for the AVAudioPlayer
      * and preparing it for play.
     */
    func loadUrl(_ url: URL) {
        player = try? AVAudioPlayer(contentsOf: url)
        player?.delegate = self
        player?.prepareToPlay()
        audioDuration = player?.duration
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    /**
     This method is used by the CADisplayLink selector to update the progress of the audio player.
     */
    func trackAudio() {
        let progress = Float((player?.currentTime ?? 0.0) / (audioDuration ?? 0.0))
        print("Progress: \(progress)")
        audioProgress.progress = progress
    }
    
    /**
     This method could be used to play the audio.
     */
    func playAudio() {
        delegate?.audioDidPlay?()
        playPauseButton.isSelected = true
        progressUpdater = CADisplayLink(target:self, selector: #selector(YoutubeAudioPlayer.trackAudio))
        progressUpdater?.preferredFramesPerSecond = 1
        progressUpdater?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        player?.play()
    }
    /**
     This method is used to stop the audio
     Warning-- this method must be called in viewWillDisapear to invalidate the CADisplayLink since it's holding a
     strong refrence to the view and will keep the Controller in the heap.
     */
    func stopAudio() {
        delegate?.audioDidStop?()
        playPauseButton.isSelected = false
        progressUpdater?.invalidate()
        player?.pause()
    }
    
    ///////////////////////////////////////////
    private func xibSetup() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView)
    }
    
    private func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}

extension YoutubeAudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.audioEnded?()
        audioProgress.progress = 0
        progressUpdater?.invalidate()
        playPauseButton.isSelected = false
    }
}
