//
//  GradientView.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/2/22.
//

import UIKit


// this creates a gradient view with our themeatic elements
// used as button backgrounds and in our splash screen
class GradientView: UIView, CAAnimationDelegate {

    /// says weither the gradient should be vertical or horizontal
    private var isVertical: Bool = true

    
    // used to initialize
    init(isVertical: Bool){
        super.init(frame: .zero)
        self.isVertical = isVertical
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func draw(_ rect: CGRect) {
            super.draw(rect)
            makeGradient()
        }

    
    private func makeGradient(){
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        currentContext.saveGState()

        // since I was unable to smoothly dampen the gradient between the designs original colors,
        // I dampened them between 3 colors along the scale to achieve the closest possible effect
        let startGrad = ProjectThemes.greenGradientDark
        let midGrad = ProjectThemes.greenGradientMid
        let lastGrad = ProjectThemes.greenGradientLight


        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors:[UIColor] = [startGrad, midGrad, lastGrad]

        var colorComponents: [CGFloat] = []

        for color in colors {
            if let components = color.cgColor.components {
                colorComponents.append(contentsOf: components)
            }
        }

        let locations:[CGFloat] = [0, 0.3, 1]

        guard let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents,locations: locations,count: colors.count) else { return }


        var startPoint: CGPoint!
        var endPoint: CGPoint!

        if isVertical {
             startPoint = CGPoint(x: 0, y: 0)
             endPoint = CGPoint(x:0, y: self.bounds.height)

        } else {
            startPoint =  CGPoint(x:bounds.width, y: 0)
            endPoint = CGPoint(x: 0, y: 0)

        }

            currentContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue:0))
            currentContext.restoreGState()

    }

 

}
