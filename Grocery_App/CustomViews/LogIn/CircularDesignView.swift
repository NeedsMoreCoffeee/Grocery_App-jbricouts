//
//  CircularDesignView.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/2/22.
//

import UIKit


// this is a view used as a background design. It creates 2 circles
class CircularDesignView:UIView{
    
    private var circleColor: UIColor!

    
    var shapeLayer: [CAShapeLayer]!

    
    init(circleColor: UIColor){
        super.init(frame: .zero)
        self.circleColor = circleColor
        shapeLayer = [CAShapeLayer(), CAShapeLayer()]

        backgroundColor = .clear
        
    }
    
    override func draw(_ rect: CGRect) {
        drawCircle()
    }
    
   private func drawCircle(){
        
        let origin = CGPoint(x: bounds.width/2, y: bounds.height/2)
        
        for i in 1...2{
        // create the circle
        let circlePath = UIBezierPath(arcCenter: origin, radius: CGFloat(bounds.height/(2 * CGFloat(i))), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            
            let index = i - 1
        shapeLayer[index].path = circlePath.cgPath
            
        // Change the fill color
        shapeLayer[index].fillColor = UIColor.clear.cgColor
        // You can change the stroke color
        shapeLayer[index].strokeColor = circleColor.cgColor
        // You can change the line width
            shapeLayer[index].lineWidth = 4.0
            
        layer.addSublayer(shapeLayer[index])
            
        }
        
    }
    
    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))

        // Set the animation duration appropriately
        animation.duration = duration

        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1

        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        for (index, shapeLayer) in shapeLayer.enumerated() {
            
            animation.duration = duration + Double(index) * 0.5

        
        shapeLayer.strokeEnd = 1.0

        // Do the actual animation
        shapeLayer.add(animation, forKey: "animateCircle")
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
