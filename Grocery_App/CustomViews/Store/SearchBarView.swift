//
//  SearchBarView.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/3/22.
//

import UIKit

// our search bar that will look up items thats located in our HomeHeaderBar
class SearchBarView: UIView {

    // the image inside of our custom text entry field
   private var typeFieldImageView: UIImageView!
    
  // the text field inside our view
   private var textField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // adds text field, and search icon views
        setUpViews()
        
        // set the placeholder text and search icon image
        setInputView(placeHolederText: "Search products...", textFieldAssociatedIcon: UIImage(named: "search_icon")!)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}







// MARK: Layout...
extension SearchBarView{
    
   
    // adds the typeView and image view
   private func setUpViews(){
       backgroundColor = .white
       createBounds()
       
       // add search icon view
       typeFieldImageView = UIImageView()
       typeFieldImageView.tintColor = .lightGray
        addsView(typeFieldImageView)
        NSLayoutConstraint.activate([
            typeFieldImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            typeFieldImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            typeFieldImageView.widthAnchor.constraint(equalToConstant: 17),
            typeFieldImageView.heightAnchor.constraint(equalToConstant: 17)

        ])
        
       // add the user type view
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
    
    
    // created the bounds of our view. Gives our view its rounded corners
   public func createBounds(){
        clipsToBounds = false
        layer.cornerRadius = 16
        addThematicShadow()
   }
    
   
    
}
