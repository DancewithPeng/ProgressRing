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
        ring.progress = 0.45
        ring.backgroundColor = .gray
    }
    
    @IBAction func randomButtonDidTap(_ sender: Any) {
        ring.progress = Float.random(in: 0...1)
    }
}

