//
//  Helper.swift
//  handWashReminder
//
//  Created by Gabriel Oliveira on 11/10/16.
//  Copyright © 2016 Bepid. All rights reserved.
//

import UIKit

func random() -> Float {
    return Float(arc4random()) / 0xFFFFFFFF
}


func random(min: Float, max: Float) -> Int {
    return Int(random() * (max - min) + min)
}
