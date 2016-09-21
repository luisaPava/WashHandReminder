//
//  PassoViewController.swift
//  handWashReminder
//
//  Created by Gabriel Oliveira on 12/09/16.
//  Copyright © 2016 Bepid. All rights reserved.
//

import UIKit

class PassoViewController: UIViewController {
    @IBOutlet weak var carousel: iCarousel!
    
    var indexCarousel: Int = 0

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //iCarousel settings
        carousel.delegate = self
        carousel.dataSource = self
        carousel.type = .rotary
        carousel.centerItemWhenSelected = true
        carousel.bounces = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - iCarousel Delegate
extension PassoViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        // Set iCarousel wheel radius
        if option == .radius {
            return self.view.bounds.width / 1.6
            
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
        return 5
    }
    
    // Return each 'cell' to be shown in iCarousel
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 1.5, height: self.view.bounds.height / 2))
        tempView.backgroundColor = UIColor.blue
        tempView.layer.borderColor = UIColor.black.cgColor
        
//        tempView.image = UIImage(named: "Notificacao")
        
        return CustomCarouselView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 1.5, height: self.view.bounds.height / 2))
        
    }
}
