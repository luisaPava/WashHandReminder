//
//  ViewController.swift
//  handWashReminder
//
//  Created by Luisa Mello on 9/2/16.
//  Copyright © 2016 Bepid. All rights reserved.
//

import UIKit
import CircleMenu
import PopupController

class ViewController: UIViewController {
    
    @IBOutlet weak var instrucoesButtonOutlet: UIButton!
    @IBOutlet weak var circleMenuButton: CircleMenu!
    fileprivate var buttons: Array<String> = ["curiosidade", "tips"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleMenuButton.delegate = self
        
        //Create circle menu programmatically
        let button = CircleMenu(
            frame: CGRect(x: view.frame.width / 11.2, y: view.frame.height / 1.11, width: view.frame.width / 8.28, height: view.frame.height / 14.72),
            normalIcon:"info",
            selectedIcon:"info",
            buttonsCount: 2,
            duration: 2,
            distance: 100)
        
        print(self.view.bounds.height)
        
        button.delegate = self
        button.layer.cornerRadius = button.frame.size.width / 2.0
        self.view.addSubview(button)
        
        circleMenuButton.isHidden = true
        
        button.delegate = self
        
        self.navigationController?.isNavigationBarHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    //MARK: - Actions
    @IBAction func instrucoesButtonAction(_ sender: UIButton) {
        ButtonAnimation.addButtonPressAnimationToView(viewToAnimate: instrucoesButtonOutlet)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.09) {
            self.performSegue(withIdentifier: "mainToInst", sender: self)
        }
        
        
        print("btn")
    }
    
    @IBAction func notificacoesButtonAction(_ sender: UIButton) {
        ButtonAnimation.addButtonPressAnimationToView(viewToAnimate: sender)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.09) {
            self.performSegue(withIdentifier: "mainToNot", sender: self)
        }
    }
}

//MARK: - Circle Menu Delegate
extension ViewController: CircleMenuDelegate {
    
    //Images for each button in circle menu
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.setImage(UIImage(named: buttons[atIndex]), for: UIControlState())
    }
    
    //Actions for each button
    func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        ButtonAnimation.addButtonPressAnimationToView(viewToAnimate: button)
        
        if atIndex == 0 {
            let popup = PopupController.create(self)
            
            let container = PopUpViewController.instance()
            container.closeHandler = { _ in
                popup.dismiss()
            }
            
            let _ = popup.show(container)
            
        } else if atIndex == 1 {
            let popup = PopupController.create(self)
            
            let container = PopUpViewControllerDicas.instance()
            
            container.closeHandler = { _ in
                popup.dismiss()
            }
            
            let _ = popup.show(container)
        }
    }
}

