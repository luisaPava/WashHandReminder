//
//  DAOPassos.swift
//  handWashReminder
//
//  Created by Gabriel Oliveira on 11/10/16.
//  Copyright © 2016 Bepid. All rights reserved.
//

import Foundation

class DAOPassos {
    static let sharedInstance = DAOPassos()
    private var vet: NSDictionary = [:]
    private var count: Int!
    private var arrayTempo: [Double] = [5, 5, 6, 12, 6, 12, 12, 12, 5, 5, 5, 5]
    
    private init() {
        popula()
        count = vet.count
    }
    
    private func popula() {
        let plist = Plist(name: "PassoAPasso")
        
        vet = (plist?.getValuesInPlistFile())!
    }
    
    func getString(atIndex: Int) -> String {
        return vet.object(forKey: "\(atIndex)") as! String
    }
    
    func getCount() -> Int {
        return count
    }
    
    func getTempo(atIndex: Int) -> Double {
        
        return arrayTempo[atIndex]
    }
}
