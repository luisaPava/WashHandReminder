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

//extension UITextView {
//    func setText(text: String, storedOffset: CGPoint, scrollToEnd: Bool) {
//        self.text = text
//        let delayInSeconds = 0.001
////        DispatchTime.now(<#T##when: dispatch_time_t##dispatch_time_t#>, <#T##delta: Int64##Int64#>)
//        
//        
//        
//        
////        let popTime: dispatch_time_t = dispatch_time_t(UInt64(Int64(delayInSeconds * Double(NSEC_PER_SEC))))
////        dispatch_after(popTime, DispatchQueue.main, {
////            self.setContentOffset(storedOffset, animated: false)
////            if scrollToEnd && !text.isEmpty {
////                let popTime: dispatch_time_t = dispatch_time_t(UInt64(Int64(delayInSeconds * Double(NSEC_PER_SEC))))
////                dispatch_after(popTime, DispatchQueue.main, {
////                    self.scrollRangeToVisible(NSMakeRange(text.lengthOfBytes(using: String.Encoding.utf8) - 1, 0))
////                })
////            }
////        })
////    }
//}
