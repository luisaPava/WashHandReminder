//
//  PopUpViewController.swift
//  handWashReminder
//
//  Created by Gabriel Oliveira on 15/09/16.
//  Copyright © 2016 Bepid. All rights reserved.
//

import UIKit
import PopupController

class PopUpViewController: UIViewController, PopupContentViewController {
    var popupSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupSize = CGSize(width: 300, height: 300)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func instance() -> PopUpViewController {
        let storyboard = UIStoryboard(name: "PopUpViewController", bundle: nil)
        return storyboard.instantiateInitialViewController() as! PopUpViewController
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return popupSize
    }
}
