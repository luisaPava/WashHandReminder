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

    fileprivate var firstAppear = true
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstAppear {
            do {
                try playVideo()
                firstAppear = false
            } catch AppError.invalidResource(let name, let type) {
                debugPrint("Could not find resource \(name).\(type)")
            } catch {
                debugPrint("Generic error")
            }
            
        }
    }
    
    fileprivate func playVideo() throws {
        guard let path = Bundle.main.path(forResource: "video", ofType:"m4v") else {
            throw AppError.invalidResource("video", "m4v")
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }

}

enum AppError : Error {
    case invalidResource(String, String)
}
