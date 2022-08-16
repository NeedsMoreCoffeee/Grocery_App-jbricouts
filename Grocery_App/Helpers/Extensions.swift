//
//  Extensions.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/4/22.
//

import Foundation
import UIKit

extension UIView{
    
    public func addThematicShadow(){
        self.layer.shadowOffset = CGSize(width: 0, height: 15)
        self.layer.shadowRadius = 25
        self.layer.shadowOpacity = 0.1
    }
    
    
    
    func addFullView(_ view: UIView, parent: UIView){
        addsView(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: parent.topAnchor),
            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
        ])
        
        
    }
    
    func addsView(_ view: UIView){
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func fadeInAnimation(speed: CGFloat = 0.2, delay: CGFloat = 0.0){
        UIView.animate(withDuration: speed, delay: delay, options: .curveEaseIn, animations:{
            
        }, completion: { _ in
            
        })
        
    }
    
}



