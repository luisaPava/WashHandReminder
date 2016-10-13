//
//  Dicas.swift
//  handWashReminder
//
//  Created by Gabriel Oliveira on 13/10/16.
//  Copyright © 2016 Bepid. All rights reserved.
//

import Foundation

class DAODicas {
    static let sharedInstance = DAODicas()
    private var vet: NSDictionary = [:]
    private var count: Int!
    
    private init() {
        popula()
        count = vet.count
    }
    
    private func popula() {
        let plist = Plist(name: "Dicas")
        
        vet = (plist?.getValuesInPlistFile())!
    }
    
    func getString(atIndex: Int) -> String {
        print(atIndex)
        return vet.object(forKey: "\(atIndex)") as! String
    }
    
    func getCount() -> Int {
        return count
    }
}
