//
//  CustomView.swift
//  CarouselViewExample
//
//  Created by Matteo Tagliafico on 03/04/16.
//  Copyright © 2016 Matteo Tagliafico. All rights reserved.
//

import UIKit

class CustomCarouselView: UIView {
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var timer: CircleTimer!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var desc: UITextView!
    
    private var containerView: UIView!
    private let customViewNibName = "CustomView"
    
    
    // MARK: init methods
    convenience init(frame: CGRect, number: String) {
        self.init(frame: frame)
        numberLabel.text = number
        
        //Timer settings
        self.timer.isActive = true
        self.timer.totalTime = 20
        self.timer.elapsedTime = 0
        
        self.imagem.contentMode = .scaleAspectFit
        self.desc.setContentOffset(CGPoint.zero, animated: false)
        
//        self.timer.start()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setupUI()
        
        //Timer settings
        self.timer.delegate = self
        self.timer.isActive = true
        self.timer.totalTime = 20
        self.timer.elapsedTime = 0
    }
    
    override func layoutSubviews() {
        self.imagem.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setupUI()
    }
    
    func xibSetup() {
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(containerView)
    }
    
    func loadViewFromNib() -> UIView {
//        let bundle = NSBundle(forClass: self.dynamicType)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: customViewNibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setupUI() {
        layer.masksToBounds = false
        layer.shadowRadius = 30
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.65

    }
}

extension CustomCarouselView: CircleTimerDelegate {
    
}
