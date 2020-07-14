//
//  ViewController.swift
//  DPProgressRingExample
//
//  Created by 张鹏 on 2020/7/13.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPProgressRing

class ViewController: UIViewController {
    
    lazy var ring = ProgressRing(frame: CGRect(x: 100, y: 100, width: 200, height: 200))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(ring)
        ring.progress         = 0.45
        ring.isClockwise      = true
        ring.startAngleOffset = -CGFloat.pi/2.0
        
        ring.placeholderColor = UIColor.lightGray
        ring.progressColor    = UIColor.yellow
    }
    
    @IBAction func randomButtonDidTap(_ sender: Any) {
        ring.progress = Float.random(in: 0...1)
    }
    
    @IBAction func animatedRandomButtonDidTap(_ sender: Any) {
        ring.setProgress(Float.random(in: 0...1), animated: true)
    }
}

