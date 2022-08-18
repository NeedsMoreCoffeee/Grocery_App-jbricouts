//
//  ItemAmountPicker.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/17/22.
//

import UIKit

class ItemAmountPicker: UIView {

    private var amountLabel: UILabel!

    private var itemAmount = 1{
        didSet{
            amountLabel.text = "\(itemAmount)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    
    @objc func incrementButtonTapped(sender: UIGestureRecognizer){
        let isIncrementing = sender.view!.tag == 1
        
        if isIncrementing{
            itemAmount += 1
        } else {
            if itemAmount == 0 { return }
            itemAmount -= 1
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }

    
    private func setUpView(){
        backgroundColor = .clear

        let buttonSize = 27.0
        
       
        let buttonHeight = 27.0
        let addButton = GradientView(isVertical: false)
        addButton.layer.cornerRadius = buttonSize / 2
        addButton.tag = 1
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = buttonHeight / 2
        addsView(addButton)
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: buttonSize),
            addButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
        
        let editButtonImageView = UIImageView(image: UIImage(named: "plus_icon"))
        editButtonImageView.tintColor = .white
        addButton.addsView(editButtonImageView)
        NSLayoutConstraint.activate([
            editButtonImageView.centerXAnchor.constraint(equalTo: addButton.centerXAnchor),
            editButtonImageView.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            editButtonImageView.widthAnchor.constraint(equalToConstant: 13),
            editButtonImageView.heightAnchor.constraint(equalToConstant: 13),

        ])
        
        amountLabel = UILabel()
        amountLabel.text = "1"
        amountLabel.font = UIFont(name: ProjectThemes.regularDMSans, size: 12)
        amountLabel.textAlignment = .center
        addsView(amountLabel)
        NSLayoutConstraint.activate([
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -5),
            amountLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        
        let minusButton = UIView()
        minusButton.backgroundColor = .white
        minusButton.layer.borderWidth = 1
        minusButton.layer.borderColor = UIColor.systemGray.cgColor
        minusButton.layer.cornerRadius = buttonSize / 2
        minusButton.tag = 0
        minusButton.clipsToBounds = true
        minusButton.layer.cornerRadius = buttonHeight / 2
        addsView(minusButton)
        NSLayoutConstraint.activate([
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: -5),
            minusButton.widthAnchor.constraint(equalToConstant: buttonSize),
            minusButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
        
        let minusButtonImageView = UIImageView(image: UIImage(named: "minus_icon"))
        minusButtonImageView.tintColor = .systemGray
        minusButton.addsView(minusButtonImageView)
        NSLayoutConstraint.activate([
            minusButtonImageView.centerXAnchor.constraint(equalTo: minusButton.centerXAnchor),
            minusButtonImageView.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            minusButtonImageView.widthAnchor.constraint(equalToConstant: 15),
            minusButtonImageView.heightAnchor.constraint(equalToConstant: 15),

        ])
        
        
      
        addButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(incrementButtonTapped(sender:))))
        minusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(incrementButtonTapped(sender:))))

       // addButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchDown)
      //  minusButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchDown)

    }
}
