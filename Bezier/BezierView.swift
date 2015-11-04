//
//  BezierView.swift
//  Bezier
//
//  Created by Ramsundar Shandilya on 10/14/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit
import Foundation

protocol BezierViewDataSource: class {
    func bezierViewDataPoints(bezierView: BezierView) -> [CGPoint]
}

class BezierView: UIView {
   
    //MARK: Public members
    weak var dataSource: BezierViewDataSource?
    
    var lineColor = UIColor(red: 233.0/255.0, green: 98.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    
    var animates = true
    
    //MARK: Private members
    
    private var dataPoints: [CGPoint]? {
        return self.dataSource?.bezierViewDataPoints(self)
    }
    
    private let cubicCurveAlgorithm = CubicCurveAlgorithm()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.sublayers?.forEach({ (layer: CALayer) -> () in
            layer.removeFromSuperlayer()
        })
        
        drawSmoothLines()
        drawPoints()
    }
    
    private func drawPoints(){
        
        guard let points = dataPoints else {
            return
        }
        
        for point in points {
            
            let circleLayer = CAShapeLayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            circleLayer.path = UIBezierPath(ovalInRect: circleLayer.bounds).CGPath
            circleLayer.fillColor = UIColor(white: 248.0/255.0, alpha: 0.5).CGColor
            circleLayer.position = point
            
            circleLayer.shadowColor = UIColor.blackColor().CGColor
            circleLayer.shadowOffset = CGSize(width: 0, height: 2)
            circleLayer.shadowOpacity = 0.7
            circleLayer.shadowRadius = 3.0
            
            self.layer.addSublayer(circleLayer)
        }
    }
    
    private func drawSmoothLines() {
        
        guard let points = dataPoints else {
            return
        }
        
        let controlPoints = cubicCurveAlgorithm.controlPointsFromPoints(points)
        
        
        let linePath = UIBezierPath()
        
        for var i=0; i<points.count; i++ {
            
            let point = points[i];
            
            if i==0 {
                linePath.moveToPoint(point)
            } else {
                let segment = controlPoints[i-1]
                linePath.addCurveToPoint(point, controlPoint1: segment.controlPoint1, controlPoint2: segment.controlPoint2)
            }
        }
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.CGPath
        lineLayer.fillColor = UIColor.clearColor().CGColor
        lineLayer.strokeColor = lineColor.CGColor
        lineLayer.lineWidth = 4.0
        
        lineLayer.shadowColor = UIColor.blackColor().CGColor
        lineLayer.shadowOffset = CGSize(width: 0, height: 8)
        lineLayer.shadowOpacity = 0.5
        lineLayer.shadowRadius = 6.0
        
        self.layer.addSublayer(lineLayer)
    }
}
