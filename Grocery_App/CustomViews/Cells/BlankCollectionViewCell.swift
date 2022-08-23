//
//  BlankCollectionViewCell.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/16/22.
//

import UIKit


// a blank cell used for testing purpouses
class BlankCollectionViewCell: UICollectionViewCell {
   static let reuseIdentifier = "BlankCollectionViewCellID"
    
   private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ProjectThemes.homeLightGrayColor
        
        label.textAlignment = .center
        label.font = UIFont(name: ProjectThemes.boldDMSans, size: 22)
        label.textColor = ProjectThemes.greenGradientDark
        addFullView(label, parent: self)
        
    }
    
    public func setText(string: String){
        label.text = string
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
