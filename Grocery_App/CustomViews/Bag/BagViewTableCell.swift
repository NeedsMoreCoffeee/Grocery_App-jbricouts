//
//  TableViewCell.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/17/22.
//

import UIKit

class BagViewTableCell: UITableViewCell {

    static public let reuseIdentifier = "bagTVcellID"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class BagViewItemsTableCell: UITableViewCell {

    static public let reuseIdentifier = "bagItemsTVcellID"
    
    let customContentView = UIView()
    
    let productImageView = UIImageView()
    let productNameLabel = UILabel()
    let productCostLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpView(){
        backgroundColor = .clear
        
        customContentView.backgroundColor = .white
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 14
        contentView.addsView(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            customContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),

        ])
        
        productImageView.backgroundColor = .white
        productImageView.image = UIImage(named: "mango3_img")
        customContentView.addsView(productImageView)
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: customContentView.topAnchor),
            productImageView.heightAnchor.constraint(equalTo: customContentView.heightAnchor),
            productImageView.widthAnchor.constraint(equalTo: customContentView.heightAnchor)
        ])
        
        
        productNameLabel.text = "Mango"
        productNameLabel.textColor = .darkGray
        productNameLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        productNameLabel.sizeToFit()
        customContentView.addsView(productNameLabel)
        NSLayoutConstraint.activate([
            productNameLabel.bottomAnchor.constraint(equalTo: customContentView.centerYAnchor, constant: -3),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 2)

        ])
        
        productCostLabel.text = "$18.09"
        productCostLabel.textColor = ProjectThemes.greenGradientDark
        productCostLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 13)
        productCostLabel.sizeToFit()
        customContentView.addsView(productCostLabel)
        NSLayoutConstraint.activate([
            productCostLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 7),
            productCostLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor)

        ])
        
        
        let pickerView = ItemAmountPicker()
        customContentView.addsView(pickerView)
        NSLayoutConstraint.activate([
            pickerView.heightAnchor.constraint(equalTo: customContentView.heightAnchor),
            pickerView.leadingAnchor.constraint(equalTo: productCostLabel.trailingAnchor, constant: 10),
            pickerView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -5.0),
            pickerView.centerYAnchor.constraint(equalTo: centerYAnchor)

        ])
        
    }
    
    
  
}

class BagViewAddressTableCell: UITableViewCell {

    static public let reuseIdentifier = "bagCouponTVcellID"
    
    let customContentView = UIView()
    
    
    var streetLabel: UILabel!
    var cityLabel: UILabel!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpView(){
        backgroundColor = .clear
        selectionStyle = .none

        customContentView.backgroundColor = .white
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 14
        contentView.addsView(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            customContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),

        ])
        
        streetLabel = UILabel()
        streetLabel.text = "1234 Apple Way"
        streetLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        streetLabel.sizeToFit()
        customContentView.addsView(streetLabel)
        NSLayoutConstraint.activate([
            streetLabel.bottomAnchor.constraint(equalTo: customContentView.centerYAnchor, constant: -5),
            streetLabel.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 20)
        ])
        
        cityLabel = UILabel()
        cityLabel.text = "Sacramento - CA"
        cityLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        cityLabel.textColor = .lightGray
        cityLabel.sizeToFit()
        customContentView.addsView(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: customContentView.centerYAnchor, constant: 5),
            cityLabel.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 20)
        ])
        
        
        let buttonHeight = 27.0
        let editButton = GradientView(isVertical: false)
        editButton.clipsToBounds = true
        editButton.layer.cornerRadius = buttonHeight / 2
        customContentView.addsView(editButton)
        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: customContentView.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            editButton.widthAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        let editButtonImageView = UIImageView(image: UIImage(named: "edit_icon"))
        editButtonImageView.tintColor = .white
        editButton.addsView(editButtonImageView)
        NSLayoutConstraint.activate([
            editButtonImageView.centerXAnchor.constraint(equalTo: editButton.centerXAnchor),
            editButtonImageView.centerYAnchor.constraint(equalTo: editButton.centerYAnchor),
            editButtonImageView.widthAnchor.constraint(equalToConstant: 18),
            editButtonImageView.heightAnchor.constraint(equalToConstant: 18),

        ])
        
    }
    
    
  
}


class BagViewCouponTableCell: UITableViewCell {

    static public let reuseIdentifier = "bagAddressTVcellID"
    
    let customContentView = UIView()
    
    var couponTypeField: UITextField!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpView(){
        backgroundColor = .clear
        selectionStyle = .none

        
        customContentView.backgroundColor = .white
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 14
        contentView.addsView(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            customContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),

        ])
        
        
        couponTypeField = UITextField()
        couponTypeField.placeholder = "Coupon"
        couponTypeField.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        customContentView.addsView(couponTypeField)
        NSLayoutConstraint.activate([
            couponTypeField.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 5),
            couponTypeField.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -5),
            couponTypeField.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 20),
            couponTypeField.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -20)

        ])
        
        let buttonHeight = 27.0

        let addCouponButton = GradientView(isVertical: false)
        addCouponButton.clipsToBounds = true
        addCouponButton.layer.cornerRadius = buttonHeight / 2
        customContentView.addsView(addCouponButton)
        NSLayoutConstraint.activate([
            addCouponButton.centerYAnchor.constraint(equalTo: customContentView.centerYAnchor),
            addCouponButton.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -20),
            addCouponButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            addCouponButton.widthAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        let addButtonImageView = UIImageView(image: UIImage(named: "plus_icon"))
        addButtonImageView.tintColor = .white
        addCouponButton.addsView(addButtonImageView)
        NSLayoutConstraint.activate([
            addButtonImageView.centerXAnchor.constraint(equalTo: addCouponButton.centerXAnchor),
            addButtonImageView.centerYAnchor.constraint(equalTo: addCouponButton.centerYAnchor),
            addButtonImageView.widthAnchor.constraint(equalToConstant: 13),
            addButtonImageView.heightAnchor.constraint(equalToConstant: 13),

        ])
        
        
        
        
    }
    
    
  
}


class BagViewTotalTableCell: UITableViewCell {

    static public let reuseIdentifier = "bagTotalTVcellID"
    
    let customContentView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpView(){
        backgroundColor = .clear
        selectionStyle = .none
        
        customContentView.backgroundColor = .clear
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 14
        contentView.addsView(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            customContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),

        ])
        
        let subTotalFixedLabel = UILabel()
        subTotalFixedLabel.text = "Sub-Total"
        subTotalFixedLabel.textColor = .systemGray
        subTotalFixedLabel.font = UIFont(name: ProjectThemes.regularDMSans, size: 13)
        subTotalFixedLabel.sizeToFit()
        customContentView.addsView(subTotalFixedLabel)
        NSLayoutConstraint.activate([
            subTotalFixedLabel.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 10),
            subTotalFixedLabel.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 0)
            
        ])
        
        let subTotalLabel = UILabel()
        subTotalLabel.text = "$74.07"
        subTotalLabel.textColor = .black
        subTotalLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        subTotalFixedLabel.sizeToFit()
        customContentView.addsView(subTotalLabel)
        NSLayoutConstraint.activate([
            subTotalLabel.centerYAnchor.constraint(equalTo: subTotalFixedLabel.centerYAnchor, constant: 0),
            subTotalLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: 0)
            
        ])
        
        
        let couponFixedLabel = UILabel()
        couponFixedLabel.text = "Coupon: None"
        couponFixedLabel.textColor = .systemGray
        couponFixedLabel.font = UIFont(name: ProjectThemes.regularDMSans, size: 13)
        couponFixedLabel.sizeToFit()
        customContentView.addsView(couponFixedLabel)
        NSLayoutConstraint.activate([
            couponFixedLabel.topAnchor.constraint(equalTo: subTotalFixedLabel.bottomAnchor, constant: 30),
            couponFixedLabel.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 0)
            
        ])
        
        let couponLabel = UILabel()
        couponLabel.text = "$0.00"
        couponLabel.textColor = .black
        couponLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        couponFixedLabel.sizeToFit()
        customContentView.addsView(couponLabel)
        NSLayoutConstraint.activate([
            couponLabel.centerYAnchor.constraint(equalTo: couponFixedLabel.centerYAnchor, constant: 0),
            couponLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: 0)
        ])
        
        let taxFixedLabel = UILabel()
        taxFixedLabel.text = "Tax"
        taxFixedLabel.textColor = .systemGray
        taxFixedLabel.font = UIFont(name: ProjectThemes.regularDMSans, size: 13)
        taxFixedLabel.sizeToFit()
        customContentView.addsView(taxFixedLabel)
        NSLayoutConstraint.activate([
            taxFixedLabel.topAnchor.constraint(equalTo: couponFixedLabel.bottomAnchor, constant: 30),
            taxFixedLabel.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 0)
            
        ])
        
        let taxLabel = UILabel()
        taxLabel.text = "Free"
        taxLabel.textColor = ProjectThemes.greenGradientDark
        taxLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        taxFixedLabel.sizeToFit()
        customContentView.addsView(taxLabel)
        NSLayoutConstraint.activate([
            taxLabel.centerYAnchor.constraint(equalTo: taxFixedLabel.centerYAnchor, constant: 0),
            taxLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: 0)
        ])
        
    }
    
    
  
}

