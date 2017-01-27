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
    @IBOutlet weak var infinityLabel: UILabel!
    var desc2: UITextView!
    
    private var containerView: UIView!
    private let customViewNibName = "CustomView"
    private let deviceName = UIDevice.current.modelName
    
    
    // MARK: init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setupUI()
        
        //Timer settings
        self.timer.delegate = self
        self.timer.isActive = false
//        self.timer.totalTime = 10
        self.timer.elapsedTime = 0
        
        //Timer settings
        self.timer.isActive = true
        self.timer.elapsedTime = 0
        
        
        //TextField Settings
        let height = self.bounds.height
        
        self.desc2 = UITextView(frame: CGRect(x: height / 28.4, y: height / 1.47, width: height / 1.57, height: height / 4.2))
        self.desc2.font = UIFont(name: "Helvetica", size: CGFloat(getFontSize()))
        self.desc2.textColor = UIColor.white
        self.desc2.backgroundColor = UIColor.clear
        self.desc2.textAlignment = .left
        self.desc2.isEditable = false
        self.desc2.isSelectable = false
        
        self.addSubview(desc2)
        
        infinityLabel.isHidden = true
        
        self.imagem.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        self.imagem.clipsToBounds = true
    }
    
    private func getFontSize() -> Int {
        if deviceName.contains("Plus") {
            return 20
        } else if deviceName.contains("6") || deviceName.contains("7") {
            return 20
        } else {
            return 16
        }
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
