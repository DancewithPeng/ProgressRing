//
//  ProgressRing.swift
//  DPProgressRing
//
//  Created by 张鹏 on 2020/7/13.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

/// 进度环
public class ProgressRing: UIView {
    
    // MARK: - Public Properties
    
    /// 最大值
    public var maximum: Float = 1
    
    /// 最小值
    public var minimum: Float = 0
    
    /// 进度
    public var progress: Float = 0 { didSet { updateProgressAppearance() }}
    
    /// 环的宽度
    public var width: CGFloat = 6
    
    /// 环的帽檐
    public var cap: CAShapeLayerLineCap = .round
    
    /// 进度环的颜色
    public var progressColor = UIColor(red: CGFloat(42.0/255.0), green: CGFloat(179.0/255.0), blue: CGFloat(196.0/255.0), alpha: 1.0)
    
    /// 占位环的颜色
    public var placeholderColor = UIColor(red: CGFloat(225.0/255.0), green: CGFloat(221.0/255.0), blue: CGFloat(221.0/255.0), alpha: 1.0)
        
    // MARK: - Private Properties
    
    private lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth   = self.width
        layer.lineCap     = self.cap
        layer.strokeColor = self.progressColor.cgColor
        layer.backgroundColor = UIColor.red.cgColor
        return layer
    }()
    
    private lazy var placeholderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth   = self.width
        layer.lineCap     = self.cap
        layer.strokeColor = self.placeholderColor.cgColor
        return layer
    }()
    
    // MARK: - KVO
    
    public override var bounds: CGRect {
        didSet {
            let squareLength = max(bounds.width, bounds.height)
            let squareSize = CGSize(width: squareLength, height: squareLength)
            let squareOrigin = CGPoint(x: (bounds.width-squareLength)/2.0, y: (bounds.height-squareLength)/2.0)
            let square = CGRect(origin: squareOrigin, size: squareSize)
            let path = CGPath(ellipseIn: square, transform: nil)
            
            placeholderLayer.path = path
            placeholderLayer.bounds = bounds
            
            let progressScale = progress / (maximum - minimum)
            progressLayer.path = UIBezierPath(arcCenter: center, radius: squareLength/2.0, startAngle: 0, endAngle: CGFloat.pi*2*CGFloat(progressScale), clockwise: true).cgPath
            progressLayer.bounds = bounds
        }
    }
    
    // MARK: - Life Cycle Methods    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if placeholderLayer.superlayer != layer {
            layer.addSublayer(placeholderLayer)
        }
        
        print(placeholderLayer)
        
//        if progressLayer.superlayer != layer {
//            layer.addSublayer(progressLayer)
//        }
    }
    
    // MARK: - Interface Methods
    
    /// 设置进度值
    /// - Parameters:
    ///   - progress: 进度值
    ///   - animated: 是否添加动画
    public func setProgress(_ progress: Float, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.progress = progress
            }
        } else {
            self.progress = progress
        }
    }
}

// MARK: - Helper Methods
extension ProgressRing {
    
    /// 更新进度的外观
    func updateProgressAppearance() {
        let squareLength = max(bounds.width, bounds.height)
        let progressScale = progress / (maximum - minimum)
        progressLayer.path = UIBezierPath(arcCenter: center, radius: squareLength/2.0, startAngle: 0, endAngle: CGFloat.pi*2*CGFloat(progressScale), clockwise: true).cgPath
    }
    
    /// 更新占位符的外观
    func updatePlaceholderAppearance() {
        
    }
}
