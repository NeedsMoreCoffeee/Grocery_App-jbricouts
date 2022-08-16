//
//  UserTypeView.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/2/22.
//

import UIKit


// a custom text entry field, an outlined view with an image leading a textField
class UserTypeView: UIView {
    
    // the image inside of our custom text entry field
   private var typeFieldImageView: UIImageView!
    
  // the text field inside our view
   private var textField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        createBounds()
        setUpViews()


    }
    
    /// sets the image and placeholder text of our view
    public func setInputView(placeHolederText: String, textFieldAssociatedIcon: UIImage){
        textField.placeholder = placeHolederText
        typeFieldImageView.image = textFieldAssociatedIcon
    }
    
    /// clears our text field, reshowing the place holder text
    public func clearText(){
        textField.text = ""
    }
    
    // created the bounds of our view. Gives our view its rounded corners
   public func createBounds(){
        clipsToBounds = true
        layer.cornerRadius = 16
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }
    
   private func setUpViews(){
        typeFieldImageView = UIImageView()
        typeFieldImageView.tintColor = ProjectThemes.greenGradientDark
        addsView(typeFieldImageView)
        NSLayoutConstraint.activate([
            typeFieldImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            typeFieldImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            typeFieldImageView.widthAnchor.constraint(equalToConstant: 17),
            typeFieldImageView.heightAnchor.constraint(equalToConstant: 17)

        ])
        
         textField = UITextField()
        textField.placeholder = "E-mail"
        textField.textAlignment = .left
        textField.font = UIFont(name: ProjectThemes.regularDMSans, size: 14)
        addsView(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: typeFieldImageView.trailingAnchor, constant: 15),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
