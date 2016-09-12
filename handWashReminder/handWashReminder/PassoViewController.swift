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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        carousel.delegate = self
        carousel.dataSource = self
        carousel.type = .Rotary
        carousel.centerItemWhenSelected = true
        carousel.bounces = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - iCarousel Delegate
extension PassoViewController: iCarouselDelegate {
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        // Set iCarousel wheel radius
        if option == .Radius {
            return self.view.bounds.width / 1.6
            
            // Set how many iCarousel items will be visible
        } else if option == .VisibleItems {
            return 3
        }
        
        return value
    }
}

//MARK: - iCarousel Data Source
extension PassoViewController: iCarouselDataSource {
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return 5
    }
    
    // Return each 'cell' to be shown in iCarousel
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        let tempView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 1.5, height: self.view.bounds.height / 2))
        tempView.backgroundColor = UIColor.blueColor()
        tempView.layer.borderColor = UIColor.blackColor().CGColor
        
//        tempView.image = UIImage(named: "Notificacao")
        
        return tempView
        
    }
}
