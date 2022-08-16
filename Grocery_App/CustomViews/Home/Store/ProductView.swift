//
//  ProductView.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/15/22.
//

import UIKit

class ProductView: UIView {
    
    private var productImageView: UIImageView!
    private var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ProjectThemes.homeLightGrayColor
        setUpView()
    }
    
    
    @objc func backButtonPressed(){
        removeFromSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


// MARK: Layout....
extension ProductView{
    
    
    
    private func setUpView(){
        productImageView = UIImageView()
        productImageView.image = UIImage(named: "mango3_img")
        addsView(productImageView)
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: widthAnchor)
        ])
        
        
        let backArrowButton = UIView()
        backArrowButton.backgroundColor = .black
        backArrowButton.layer.cornerRadius = 29
        backArrowButton.alpha = 0.5
        addsView(backArrowButton)
        NSLayoutConstraint.activate([
            backArrowButton.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            backArrowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            backArrowButton.widthAnchor.constraint(equalToConstant: 58),
            backArrowButton.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        backArrowButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonPressed)))
        
        let backArrowIcon = UIImageView(image: UIImage(named: "back_arrow_icon"))
        backArrowIcon.tintColor = .white
        backArrowButton.addFullView(backArrowIcon, parent: backArrowButton)
        
        let infoView = UIView()
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 40.0
        addsView(infoView)
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -50.0),
            infoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        
       let insetIcon = UIView()
        insetIcon.backgroundColor = .lightGray
        insetIcon.alpha = 0.7
        insetIcon.layer.cornerRadius = 2.5
        infoView.addsView(insetIcon)
        NSLayoutConstraint.activate([
            insetIcon.topAnchor.constraint(equalTo: infoView.topAnchor,constant: 15),
            insetIcon.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            insetIcon.widthAnchor.constraint(equalToConstant: 75),
            insetIcon.heightAnchor.constraint(equalToConstant: 5)
        
        ])
        
         titleLabel = UILabel()
         titleLabel.text = "Mango"
        titleLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 22)
        titleLabel.sizeToFit()
        infoView.addsView(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 37),
            titleLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 32)
        ])
        
        let productTraitView = createDescriptiveTagIcon(text: "400g")
        productTraitView.backgroundColor = ProjectThemes.lightGreenSubTextColor
        productTraitView.layer.cornerRadius = 8
        infoView.addsView(productTraitView)
        NSLayoutConstraint.activate([
            productTraitView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            productTraitView.widthAnchor.constraint(equalToConstant: 60),
            productTraitView.heightAnchor.constraint(equalToConstant: 30),
            productTraitView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 32)
        ])
        
        let descriptionView = UITextView()
        descriptionView.text = " Sed et vulputate turpis dolor, ac nisi tortor. Mattis varius sapien sit erat maecenas maecenas vestibulum lectus leo. Morbi blandit at netus cursus lacu. "
        descriptionView.font = UIFont(name: ProjectThemes.regularDMSans, size: 14)
        descriptionView.textColor = .systemGray
        descriptionView.sizeToFit()
        infoView.addsView(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: productTraitView.bottomAnchor, constant: 5),
            descriptionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            descriptionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let priceLabel = UILabel()
        priceLabel.text = "Price"
        priceLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 15)
        priceLabel.sizeToFit()
        priceLabel.textColor = .systemGray
        infoView.addsView(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor)
        ])
       
        
        let cashLabel = UILabel()
        cashLabel.textColor = ProjectThemes.greenGradientDark
        cashLabel.text = "$"
        cashLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 15)
        cashLabel.sizeToFit()
        infoView.addsView(cashLabel)
        NSLayoutConstraint.activate([
            cashLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3),
            cashLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor)
        ])
        
        let costLabel = UILabel()
        costLabel.textColor = .black
        costLabel.text = "5.29"
        costLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 17)
        costLabel.sizeToFit()
        infoView.addsView(costLabel)
        NSLayoutConstraint.activate([
            costLabel.bottomAnchor.constraint(equalTo: cashLabel.bottomAnchor),
            costLabel.leadingAnchor.constraint(equalTo: cashLabel.trailingAnchor, constant: 5)
        ])
        
        let addToCartView = createAddToCartView()
        infoView.addsView(addToCartView)
        NSLayoutConstraint.activate([
            addToCartView.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            addToCartView.bottomAnchor.constraint(equalTo: costLabel.bottomAnchor),
            addToCartView.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: 15),
            addToCartView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor)
        ])
        
        
    }
    
    private func createAddToCartView() -> UIView{
        let addToCartView = GradientView(isVertical: false)
        addToCartView.layer.cornerRadius = 16
        addToCartView.clipsToBounds = true
        
        
        let signInLabel = UILabel()
        signInLabel.text = "Add To Cart"
        signInLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 14)
        signInLabel.textColor = .white
        signInLabel.textAlignment = .center
        addToCartView.addFullView(signInLabel, parent: addToCartView)
        
        return addToCartView
        
    }
    
    private func createDescriptiveTagIcon(text: String) -> UIView{
        let descriptiveView = UIView()
        descriptiveView.backgroundColor = ProjectThemes.lightGreenSubTextColor
        descriptiveView.layer.cornerRadius = 8
        
        let descriptiveLabel = UILabel()
        descriptiveLabel.text = text
        descriptiveLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 14)
        descriptiveLabel.sizeToFit()
        descriptiveLabel.textAlignment = .center
        descriptiveLabel.textColor = ProjectThemes.greenGradientDark
        descriptiveView.addFullView(descriptiveLabel, parent: descriptiveView)
        
        return descriptiveView
    }
    
    
    
    
    
}
