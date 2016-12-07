//
//  YoutubeAudioPlayer.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 12/5/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit
import AVFoundation


@objc protocol YoutubeAudioDelegate: NSObjectProtocol {
   @objc optional func audioDidStop()
   @objc optional func audioDidPlay()
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
                delegate?.audioDidPlay?()
                sender.isSelected = true
                progressUpdater = CADisplayLink(target:self, selector: #selector(YoutubeAudioPlayer.trackAudio))
                progressUpdater?.preferredFramesPerSecond = 1
                progressUpdater?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
                
                print("Playing Audio")
                audioPlayer.play()
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
    
    func loadUrl(_ url: URL) {
        player = try? AVAudioPlayer(contentsOf: url)
        player?.delegate = self
        player?.prepareToPlay()
        audioDuration = player?.duration
    }
    
    func trackAudio() {
        let progress = Float((player?.currentTime ?? 0.0) / (audioDuration ?? 0.0))
        print("Progress: \(progress)")
        audioProgress.progress = progress
    }
    
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
    
    func stopAudio() {
        delegate?.audioDidStop?()
        playPauseButton.isSelected = false
        progressUpdater?.invalidate()
        player?.pause()
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
