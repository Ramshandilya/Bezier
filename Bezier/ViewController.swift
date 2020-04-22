//
//  ViewController.swift
//  BezierSwift3
//
//  Created by Reinier Melian Massip on 9/20/18.
//  Copyright © 2018 Reinier Melian Massip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var firstBezierView: BezierView!
	
	let dataPoints = [252, 220, 101, 2, 101, 220, 252]
	
	var xAxisPoints : [Double] {
		var points = [Double]()
		for i in 0..<dataPoints.count {
			let val = (Double(i)/6.0) * Double(self.firstBezierView.bounds.size.width)
			points.append(val)
		}
		
		return points
	}
	
	var yAxisPoints: [Double] {
		var points = [Double]()
		for i in dataPoints {
			let val = (Double(i)/255) * Double(self.firstBezierView.bounds.size.height)
			points.append(val)
		}
		
		return points
	}
	
	var graphPoints : [CGPoint] {
		var points = [CGPoint]()
		for i in 0..<dataPoints.count {
			let val = CGPoint(x: self.xAxisPoints[i], y: self.yAxisPoints[i])
			points.append(val)
		}
		
		return points
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		firstBezierView.dataSource = self
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		self.firstBezierView.layoutSubviews()
	}
}

extension ViewController: BezierViewDataSource {
	
	func bezierViewDataPoints(bezierView: BezierView) -> [CGPoint] {
		return graphPoints
	}
}

