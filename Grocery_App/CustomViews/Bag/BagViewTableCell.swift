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
        productImageView.image = UIImage(named: "mango2_img")
        customContentView.addsView(productImageView)
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: customContentView.topAnchor),
            productImageView.heightAnchor.constraint(equalTo: customContentView.heightAnchor),
            productImageView.widthAnchor.constraint(equalTo: customContentView.heightAnchor)
        ])
        
        
        productNameLabel.text = "Apple"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpView(){
        backgroundColor = .clear
        
        customContentView.backgroundColor = .systemBlue
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 14
        contentView.addsView(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            customContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),

        ])
        
        
        
    }
    
    
  
}


class BagViewCouponTableCell: UITableViewCell {

    static public let reuseIdentifier = "bagAddressTVcellID"
    
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
        
        customContentView.backgroundColor = .systemRed
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 14
        contentView.addsView(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            customContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),

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
        
        customContentView.backgroundColor = .systemCyan
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 14
        contentView.addsView(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            customContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),

        ])
        
        
        
    }
    
    
  
}

