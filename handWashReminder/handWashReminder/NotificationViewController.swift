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
    @IBOutlet weak var ativarBtnOutlet: UIButton!
    
    private let center = UNUserNotificationCenter.current()
    private let defaults = UserDefaults.standard
    
    private let sharedDAO = DAOCuriosidades.sharedInstance

    var qtd: Double!
    var intervalo: Double = 2
    var inicio: Double = 1 { didSet {
            resultLabel.text = stringIntervalo(inicio: Int(inicio), fim: Int(fim))
        
        }
    }
    
    var fim: Double = 1 { didSet {
            resultLabel.text = stringIntervalo(inicio: Int(inicio), fim: Int(fim))
        }
    }

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
        
        ativarBtnOutlet.isSelected = defaults.bool(forKey: "ativarButtonIsSelected")
        
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
    @IBAction func ativarBtnAction(_ sender: UIButton) {
        ButtonAnimation.addButtonPressAnimationToView(viewToAnimate: sender)
        
        if !sender.isSelected {
            sender.isSelected = true
            defaults.set(true, forKey: "ativarButtonIsSelected")
            center.removeAllPendingNotificationRequests()
            createAllNotification()
        } else {
            sender.isSelected = false
            defaults.set(false, forKey: "ativarButtonIsSelected")
            center.removeAllPendingNotificationRequests()
        }
    }
    
    @IBAction func intervaloSegAction(_ sender: ADVSegmentedControl) {
        let index = sender.selectedIndex
        
        switch index {
            case 0:
                intervalo = 2
            
            case 1:
                intervalo = 1
            
            case 2:
                intervalo = 0.5
            
            default:
                break
        }
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
    
    //Create all notifications based on user choice
    func createAllNotification() {
        qtd = fim - inicio
        
        if qtd <= 0 {
            qtd! += 24
        }
        
        let count = Int(qtd * intervalo)
        var countHora = 0
        
        for i in 1...count {
            var dateComponents = DateComponents()
            let count = sharedDAO.getCount()
            let index = random(min: Float(1), max: Float(count) - 1)
            let curiosidade = sharedDAO.getString(atIndex: index)
            
            switch intervalo {
                //Uma em uma hora
                case 1:
                    var hour = Int(inicio) + i
                    
                    if hour > 24 {
                        hour -= 24
                    }
                    
                    dateComponents.hour = hour
                    createNotification(title: "Lembre-se de lavar as mãos", body: curiosidade, dateComponent: dateComponents)
                    print("Uma \(hour)")
                
                //Meia em meia hora
                case 2:
                    var hour = Int(inicio) + countHora
                    
                    if hour > 24 {
                        hour -= 24
                    }
                    
                    if (i % 2) == 0 {
                        countHora += 1
                        dateComponents.hour = hour
                        createNotification(title: "Lembre-se de lavar as mãos", body: curiosidade, dateComponent: dateComponents)
                        print("Meia \(Int(inicio) + countHora)")

                    } else {
                        dateComponents.hour = Int(inicio) + countHora
                        dateComponents.minute = 30
                        createNotification(title: "Lembre-se de lavar as mãos", body: curiosidade, dateComponent: dateComponents)
                        print("\(Int(inicio) + countHora) 30")
                    }
                
                //Duas em duas horas
                case 0.5:
                    var hour = Int(inicio) + (i * 2)
                    
                    if hour > 24 {
                        hour -= 24
                    }
                    
                    dateComponents.hour = hour
                    createNotification(title: "Lembre-se de lavar as mãos", body: curiosidade, dateComponent: dateComponents)
                    print("Duas \(Int(inicio) + (i * 2))")
                
                
                default:
                    break
            }
        }
    }
    
    //Retorna a string correta para resultLabel
    func stringIntervalo(inicio: Int, fim: Int) -> String {
        var string = ""
        
        if inicio == 1 && fim > 1 {
            string = "De \(Int(inicio))h às \(Int(fim))h"
            
        } else if inicio == 1 && fim == 1 {
            string = "De \(Int(inicio))h à \(Int(fim))h"
            
        } else if inicio > 1 && fim == 1 {
            string = "Das \(Int(inicio))h à \(Int(fim))h"
            
        } else {
            string = "Das \(Int(inicio))h às \(Int(fim))h"
            
        }
        
        return string
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
        if ativarBtnOutlet.isSelected {
            ativarBtnOutlet.setImage(#imageLiteral(resourceName: "Atualizar"), for: .normal)
            ativarBtnOutlet.isSelected = false
        }
        
        if pickerView.id == "inicio" {
            inicio = Double(item + 1)
        } else {
            fim = Double(item + 1)
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
