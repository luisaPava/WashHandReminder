//
//  PassoViewController.swift
//  handWashReminder
//
//  Created by Gabriel Oliveira on 12/09/16.
//  Copyright © 2016 Bepid. All rights reserved.
//

import UIKit
import RSPlayPauseButton

class PassoViewController: UIViewController {
    @IBOutlet weak var carousel: iCarousel!
    
    fileprivate let sharedDAO = DAOPassos.sharedInstance
    fileprivate var playPauseButton: RSPlayPauseButton! = nil
    fileprivate var autoPlay = false
    
    fileprivate var task: DispatchWorkItem!

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //iCarousel settings
        carousel.delegate = self
        carousel.dataSource = self
        carousel.type = .rotary
        carousel.centerItemWhenSelected = true
        carousel.bounces = false
        
        //Play/Pause settings
        playPauseButton = RSPlayPauseButton(frame: CGRect(x: width / 2.5, y: height / 1.23, width: 0, height: 0))
        playPauseButton.addTarget(self, action: #selector(playPauseButtonDidPress), for: .touchUpInside)
        playPauseButton.tintColor = UIColor.white
        playPauseButton.contentScaleFactor = 2
        
        self.view.addSubview(playPauseButton)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        ButtonAnimation.addButtonPressAnimationToView(viewToAnimate: sender)
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    //Play/Pause Button Action
    func playPauseButtonDidPress(playPauseButton: RSPlayPauseButton) {
        playPauseButton.setPaused(!playPauseButton.isPaused, animated: true)
        
        let view = carousel.currentItemView as! CustomCarouselView
        
        view.timer.reset()
        view.timer.start()
        
        var index = carousel.index(ofItemView: view) + 1
        
        if index == sharedDAO.getCount() {
            index = 0
        }
        
        var timer: Double
        
        if index == 0 {
            timer = sharedDAO.getTempo(atIndex: index)
            
        } else {
            timer = sharedDAO.getTempo(atIndex: index - 1)
            
        }
        
        autoPlay = !autoPlay
        
        if autoPlay {
            task = DispatchWorkItem {
                self.carousel.scrollToItem(at: index, animated: true)
            }
            
            // execute task in 2 seconds
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timer - 0.5, execute: task)
            
        } else {
            task.cancel()
            
            view.timer.reset()
            view.timer.start()
            view.timer.stop()
            
        }
        
//        let when = DispatchTime.now() + timer - 0.5
//        DispatchQueue.main.asyncAfter(deadline: when) {
//           self.carousel.scrollToItem(at: index, animated: true)
//        }
    }
}

//MARK: - iCarousel Delegate
extension PassoViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        // Set iCarousel wheel radius
        if option == .radius {
            return self.view.bounds.width / 0.7
            
        // Set how many iCarousel items will be visible
        } else if option == .visibleItems {
            return 3
        }
        
        return value
    }
}

//MARK: - iCarousel Data Source
extension PassoViewController: iCarouselDataSource {
    //Returns the number of items in iCarousel
    func numberOfItems(in carousel: iCarousel) -> Int {
        return sharedDAO.getCount()
    }
    
    
    // Return each 'cell' to be shown in iCarousel
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView = CustomCarouselView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 1.5, height: self.view.bounds.height / 1.8))
        
        tempView.imagem.image = UIImage(named: "instrucao\(index + 1)")
        tempView.desc2.text = sharedDAO.getString(atIndex: index + 1)
        
        let timer = sharedDAO.getTempo(atIndex: index)
        
        tempView.infinityLabel.isHidden = true
        
        if timer == 0 {
            tempView.timer.isHidden = true
            
            
        } else {
            tempView.timer.totalTime = timer
            print(timer)
            
        }
        
        if index == 0 && autoPlay {
            tempView.timer.start()
            
        }
        
        if !autoPlay {
            tempView.timer.start()
            tempView.timer.stop()
        }
        
        
        return tempView
        
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        let view = carousel.currentItemView as! CustomCarouselView
        
        var index = carousel.index(ofItemView: view) + 1
        
        if index == sharedDAO.getCount() {
            index = 0
        }
        
        if autoPlay {
            let timer: Double!
            view.timer.start()
            
            if index == 0 {
                timer = sharedDAO.getTempo(atIndex: index)
                
            } else {
                timer = sharedDAO.getTempo(atIndex: index - 1)
                
            }
            
            task = DispatchWorkItem {
                self.carousel.scrollToItem(at: index, animated: true)
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timer - 0.5, execute: task)
        } else {
            view.timer.start()
            view.timer.stop()
        }
    }
}
