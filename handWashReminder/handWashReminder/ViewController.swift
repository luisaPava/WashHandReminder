//
//  ViewController.swift
//  handWashReminder
//
//  Created by Luisa Mello on 9/2/16.
//  Copyright © 2016 Bepid. All rights reserved.
//

import UIKit
import CircleMenu

class ViewController: UIViewController {
    
    @IBOutlet weak var circleMenuButton: CircleMenu!
    private var buttons: Array<String> = ["curiosidade", "tips"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleMenuButton.delegate = self
        
        print(view.frame.height)
        print(view.frame.width)
        
        let button = CircleMenu(
            frame: CGRect(x: view.frame.width / 11.8, y: view.frame.height / 1.09, width: view.frame.width / 8.28, height: view.frame.height / 14.72),
            normalIcon:"info",
            selectedIcon:"info",
            buttonsCount: 2,
            duration: 2,
            distance: 100)
        button.delegate = self
        button.layer.cornerRadius = button.frame.size.width / 2.0
        self.view.addSubview(button)
        
        circleMenuButton.hidden = true
        
        button.delegate = self
        
        self.navigationController?.navigationBarHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }


}

extension ViewController: CircleMenuDelegate {
    func circleMenu(circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.setImage(UIImage(named: buttons[atIndex]), forState: .Normal)
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        print(atIndex)
    }
}

