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
    
    
    // MARK: init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setupUI()
        
        //Timer settings
        self.timer.delegate = self
        self.timer.isActive = true
        self.timer.totalTime = 20
        self.timer.elapsedTime = 0
        
        //Timer settings
        self.timer.isActive = true
        self.timer.elapsedTime = 0
        
        
        //TextField Settings
        let height = self.bounds.height
        
        self.desc2 = UITextView(frame: CGRect(x: height / 28.4, y: height / 1.42, width: height / 1.47, height: height / 4.3))
        self.desc2.font = UIFont(name: "Helvetica", size: 15)
        self.desc2.textColor = UIColor.white
        self.desc2.backgroundColor = UIColor.clear
        self.desc2.textAlignment = .left
        
        self.addSubview(desc2)
        
        infinityLabel.isHidden = true
        
        self.imagem.contentMode = .scaleAspectFit
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
