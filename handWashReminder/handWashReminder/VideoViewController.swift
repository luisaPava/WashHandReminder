//
//  VideoViewController.swift
//  handWashReminder
//
//  Created by Luisa Paiva on 9/9/16.
//  Copyright © 2016 Bepid. All rights reserved.
//



//Instruções

//  Add the video (lets call it video.m4v) to your Xcode project
//  Open the Project Navigator cmd + 1
//  Select your project root > your Target > Build Phases > Copy Bundle Resources. If your video is not listed in this list you should add it using the plus button

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {

    private var firstAppear = true
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if firstAppear {
            do {
                try playVideo()
                firstAppear = false
            } catch AppError.InvalidResource(let name, let type) {
                debugPrint("Could not find resource \(name).\(type)")
            } catch {
                debugPrint("Generic error")
            }
            
        }
    }
    
    private func playVideo() throws {
        guard let path = NSBundle.mainBundle().pathForResource("video", ofType:"m4v") else {
            throw AppError.InvalidResource("video", "m4v")
        }
        let player = AVPlayer(URL: NSURL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true) {
            player.play()
        }
    }

}

enum AppError : ErrorType {
    case InvalidResource(String, String)
}
