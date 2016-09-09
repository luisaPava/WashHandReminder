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

