//
//  ProductSearchCell.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/12/22.
//

import UIKit

class ProductSearchCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProductSearchCellID"
    
    private var productImageView: UIImageView!
    
    private var customCellContentView: UIView!
    
    private var productTitleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        
    }
    
    
    
    
    public func setCellProduct(name:String){
        productTitleLabel.text = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func setUpView(){
        self.backgroundColor = .clear
        addContentView()
        addImageView()
        addLabels()
    }
    
    private func addContentView(){
        customCellContentView = UIView()
        customCellContentView.layer.cornerRadius = 16
        customCellContentView.backgroundColor = .white
        addFullView(customCellContentView, parent: self)
        
        customCellContentView.layer.shadowOffset = CGSize(width: 0, height: 15)
        customCellContentView.layer.shadowRadius = 25
        customCellContentView.layer.shadowOpacity = 0.05
    }
    
    private func addImageView(){
        productImageView = UIImageView()
        productImageView.image = UIImage(named: "mango2_img")
        productImageView.backgroundColor = .clear
        productImageView.contentMode = .scaleAspectFit
        addsView(productImageView)
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            productImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.65),
            productImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        
    }
    
    private func addLabels(){
        
        let titleFont = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        productTitleLabel = UILabel()
        productTitleLabel.text = "Mango"
        productTitleLabel.font = titleFont
        productTitleLabel.sizeToFit()
        addsView(productTitleLabel)
        NSLayoutConstraint.activate([
            productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
            productTitleLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor)
        ])
        
        let portionAmountLabel = UILabel()
        portionAmountLabel.text = "500g"
        portionAmountLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 12)
        portionAmountLabel.sizeToFit()
        portionAmountLabel.textColor = .lightGray
        addsView(portionAmountLabel)
        NSLayoutConstraint.activate([
            portionAmountLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 0),
            portionAmountLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor)
        ])
        
    
        let priceLabel = UILabel()
        priceLabel.text = "$5.39"
        priceLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 12)
        priceLabel.sizeToFit()
        priceLabel.textColor = ProjectThemes.greenGradientDark
        addsView(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        let buttonHeight: CGFloat = 30
        
        let addButton = UIView()
        addButton.backgroundColor = ProjectThemes.greenGradientDark
        addButton.layer.cornerRadius = buttonHeight / 2
        addButton.clipsToBounds = true
        addsView(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addButton.widthAnchor.constraint(equalToConstant: buttonHeight),
            addButton.heightAnchor.constraint(equalToConstant: buttonHeight),

        
        ])
        
        let plusImageView = UIImageView(image: UIImage(named: "plus_icon"))
        plusImageView.tintColor = .white
        addButton.addsView(plusImageView)
        NSLayoutConstraint.activate([
            plusImageView.centerXAnchor.constraint(equalTo: addButton.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            plusImageView.widthAnchor.constraint(equalToConstant: 10),
            plusImageView.heightAnchor.constraint(equalToConstant: 10),

        ])
        
        
        
        
    }
    
    
    
    
}
