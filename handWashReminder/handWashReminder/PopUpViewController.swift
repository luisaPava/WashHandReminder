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
    var closeHandler: (() -> Void)?
    
    @IBOutlet weak var curiosidadeTextView: UITextView!
    
    fileprivate let sharedDAO = DAOCuriosidades.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let count = sharedDAO.getCount()
        let index = random(min: Float(1), max: Float(count) - 1)
        let curiosidade = sharedDAO.getString(atIndex: index)
        
        curiosidadeTextView.text = curiosidade
        
        popupSize = CGSize(width: 300, height: 300)
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        self.view.layer.cornerRadius = 10
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Returns PopUpViewController
    class func instance() -> PopUpViewController {
        let storyboard = UIStoryboard(name: "PopUpViewController", bundle: nil)
        return storyboard.instantiateInitialViewController() as! PopUpViewController
    }
    
    //Set PopUp size
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return popupSize
    }
    
    //Função de dismiss
    
    @IBAction func exitButton(_ sender: AnyObject) {
        closeHandler!()
    
    }
    
    
}
