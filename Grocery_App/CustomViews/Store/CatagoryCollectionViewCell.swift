//
//  CatagoryCollectionViewCell.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/5/22.
//

import UIKit

class CatagoryCollectionViewCell: UICollectionViewCell {
    
    // the custom content view we use for our label
    private var customCellContentView: UIView!
    
    private var catagoryName: ProductsController.ProductCatagories!
  
    private var catagoryImageView: UIImageView!
    
    var cellLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        customCellContentView.alpha = 0
        animateFadeIn(delay: 0.5)
     
    }
    
    public func getCatagory() -> ProductsController.ProductCatagories{
        return catagoryName
    }
    
    public func setCatagory(catagory: ProductsController.ProductCatagories){
        catagoryImageView.image = catagory.catagoryImage
        cellLabel.text = catagory.rawValue
        catagoryName = catagory
    }
    
    // fades our custom content view in to the view
    public func animateFadeIn(delay: CGFloat){
        let delay:CGFloat = CGFloat(delay) * 0.2
        UIView.animate(withDuration: 1, delay: delay , options: .curveEaseIn) {
            self.customCellContentView.alpha = 1
        }
    }
 
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: Layout
extension CatagoryCollectionViewCell{
    
     private func addViews(){
         addContentView()
         addLabel()
         clipsToBounds = false
         
     }
     
     private func addContentView(){
         customCellContentView = UIView()
         customCellContentView.layer.cornerRadius = 16
         customCellContentView.backgroundColor = .white
         addFullView(customCellContentView, parent: self)
         
         customCellContentView.layer.shadowOffset = CGSize(width: 0, height: 15)
         customCellContentView.layer.shadowRadius = 25
         customCellContentView.layer.shadowOpacity = 0.1
     }
     
     private func addLabel(){
         
         catagoryImageView = UIImageView()
         catagoryImageView.contentMode = .scaleAspectFit
         customCellContentView.addsView(catagoryImageView)
         NSLayoutConstraint.activate([
            catagoryImageView.centerXAnchor.constraint(equalTo: customCellContentView.centerXAnchor),
            catagoryImageView.centerYAnchor.constraint(equalTo: customCellContentView.centerYAnchor, constant: -15),
            catagoryImageView.widthAnchor.constraint(equalTo: customCellContentView.widthAnchor, multiplier: 0.7),
            catagoryImageView.heightAnchor.constraint(equalTo: customCellContentView.widthAnchor, multiplier: 0.7),

         ])
         
         
          cellLabel = UILabel()
         cellLabel.text = "Error"
         cellLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
         cellLabel.textAlignment = .center
         cellLabel.textColor = .black
         cellLabel.sizeToFit()
         customCellContentView.addsView(cellLabel)
         NSLayoutConstraint.activate([
             cellLabel.centerXAnchor.constraint(equalTo: customCellContentView.centerXAnchor),
             cellLabel.topAnchor.constraint(equalTo: catagoryImageView.bottomAnchor, constant: 5)

         ])
         
     }
}
