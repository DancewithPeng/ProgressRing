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
    @objc
    public var maximum: Float = 1 { didSet { updateProgressAppearance() }}
    
    /// 最小值
    @objc
    public var minimum: Float = 0 { didSet { updateProgressAppearance() }}
    
    /// 进度
    @objc
    public var progress: Float = 0 { didSet { updateProgressAppearance() }}
    
    /// 是否顺时针
    @objc
    public var isClockwise: Bool = true { didSet { updateShapePath() }}
    
    /// 环的宽度
    @objc
    public var width: CGFloat = 6 {
        didSet {
            progressLayer.lineWidth     = width
            placeholderLayer.lineWidth  = width
        }
    }
    
    /// 环的帽檐
    @objc
    public var cap: CAShapeLayerLineCap = .round {
        didSet {
            progressLayer.lineCap    = cap
            placeholderLayer.lineCap = cap
        }
    }
    
    /// 进度环的颜色
    @objc
    public var progressColor = UIColor(red: CGFloat(80.0/255.0), green: CGFloat(132.0/255.0), blue: CGFloat(195.0/255.0), alpha: 1.0) {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    /// 占位环的颜色
    @objc
    public var placeholderColor = UIColor(red: CGFloat(218.0/255.0), green: CGFloat(225.0/255.0), blue: CGFloat(235.0/255.0), alpha: 1.0) {
        didSet {
            placeholderLayer.strokeColor = placeholderColor.cgColor
        }
    }
    
    /// 开始角度的偏移
    @objc
    public var startAngleOffset: CGFloat = 0 {
        didSet {
            updateShapePath()
        }
    }
        
    // MARK: - Private Properties
    
    /// 是否启用更新进度的动画
    private var isUpdateProgressAnimationEnable = false
    
    /// 进度环
    private lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth   = self.width
        layer.lineCap     = self.cap
        layer.strokeColor = self.progressColor.cgColor
        layer.fillColor   = nil
        return layer
    }()
    
    /// 占位环
    private lazy var placeholderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth   = self.width
        layer.lineCap     = self.cap
        layer.strokeColor = self.placeholderColor.cgColor
        layer.fillColor   = nil
        return layer
    }()
    
    // MARK: - Life Cycle Methods    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderLayer.bounds = bounds
        placeholderLayer.position = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
            
        progressLayer.bounds = bounds
        progressLayer.position = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        
        updateShapePath()
        
        if placeholderLayer.superlayer != layer {
            layer.addSublayer(placeholderLayer)
        }
        
        if progressLayer.superlayer != layer {
            layer.addSublayer(progressLayer)
        }
    }
    
    // MARK: - Interface Methods
    
    /// 设置进度值
    /// - Parameters:
    ///   - progress: 进度值
    ///   - animated: 是否添加动画
    @objc
    public func setProgress(_ progress: Float, animated: Bool) {
        isUpdateProgressAnimationEnable = animated
        self.progress = progress
    }
}

// MARK: - Helper Methods
extension ProgressRing {
    
    /// 正方形形状
    var square: CGRect {
        let length = max(bounds.width, bounds.height)
        return CGRect(x: (bounds.width-length)/2.0, y: (bounds.height-length)/2.0, width: length, height: length)
    }
    
    /// 进度百分比
    var progressPercentage: CGFloat {
        return CGFloat((progress-minimum)/(maximum-minimum))
    }
    
    /// 更新图形的路径
    func updateShapePath() {
        
        let startAngle: CGFloat = -(CGFloat.pi/2) + startAngleOffset
        let endAngle: CGFloat = isClockwise ? ((CGFloat.pi/2*3) + startAngleOffset) : (-(CGFloat.pi*2+CGFloat.pi/2) + startAngleOffset)
        let ringPath = UIBezierPath(arcCenter: CGPoint(x: square.midX, y: square.midY), radius: square.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: isClockwise)
        
        placeholderLayer.path = ringPath.cgPath
        progressLayer.path    = ringPath.cgPath
        
        progressLayer.strokeEnd = progressPercentage
    }
    
    /// 更新进度外观
    func updateProgressAppearance() {
        
        CATransaction.begin()
        CATransaction.setDisableActions(!isUpdateProgressAnimationEnable)
        
        progressLayer.strokeEnd = progressPercentage
        
        CATransaction.commit()
        
        isUpdateProgressAnimationEnable = false
    }
}
