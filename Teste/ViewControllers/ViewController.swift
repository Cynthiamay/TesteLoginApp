//
//  ViewController.swift
//  Teste
//
//  Created by Treinamento on 8/28/19.
//  Copyright © 2019 cynthiamayumiwatanabeyamaoto. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    setUpVideo()
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
    }
    
    func  setUpVideo() {
        let path = Bundle.main.path(forResource: "Piggy - 12922", ofType: ".mp4")
        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path!))
        videoPlayer!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player : videoPlayer)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer!.currentItem)
        
        videoPlayer!.seek(to: CMTime.zero)
        videoPlayer!.play()
    }
    @objc func playerItemDidReachEnd() {
        videoPlayer!.seek(to: CMTime.zero)
    }
    
}
