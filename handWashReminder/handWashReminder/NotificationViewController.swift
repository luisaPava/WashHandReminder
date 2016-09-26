//
//  NotificationViewController.swift
//  handWashReminder
//
//  Created by Luisa Paiva on 9/4/16.
//  Copyright © 2016 Bepid. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    @IBOutlet weak var pickerInicio: AKPickerView!
    @IBOutlet weak var pickerFim: AKPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    let center = UNUserNotificationCenter.current()
    
    var inicio: Int = 1
    var fim: Int = 1 { didSet {
            resultLabel.text = "De \(inicio) às \(fim)"
        }
    }
//    var

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = ""

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        
        //pickerInicio and pickerFim setting
        setPicker(picker: pickerInicio, id: "inicio")
        setPicker(picker: pickerFim, id: "fim")
        
        //Request authorization to notifiations
        registerLocal()
        
//        center.removeAllPendingNotificationRequests()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex: 0x2F557D)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    
    //MARK: - Actions
    @IBAction func ativarBtnAction(_ sender: AnyObject) {
        print("botão")
//        setScheduledNotification(title: "Lembre-se de lavar as mãos", body: "Teste", inicio: inicio, fim: fim)
    }
    
    //MARK: - Other Methods
    
    //Picker setting
    func setPicker(picker: AKPickerView, id: String) {
        picker.delegate = self
        picker.dataSource = self
        picker.id = id
        picker.interitemSpacing = 30
        picker.textColor = UIColor.white
        picker.highlightedTextColor = UIColor.white
    }
    
    //Request authorization
    func registerLocal() {
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if !granted {
                //handle denial
            }
        })
    }
    
    //Schedule notification
    func createNotification(title: String, body: String, dateComponent: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: { error in
            if error != nil {
                print(error?.localizedDescription)
            }
        })
    }
}

//MARK: - UIColor Extension
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

//MARK: - AKPickerViewDelegate
extension NotificationViewController: AKPickerViewDelegate {
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        if pickerView.id == "inicio" {
            inicio = item + 1
        } else {
            fim = item + 1
        }
    }
    
}

//MARK: - AKPickerViewDataSource
extension NotificationViewController: AKPickerViewDataSource {
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return 24
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return "\(item + 1)"
    }
}
