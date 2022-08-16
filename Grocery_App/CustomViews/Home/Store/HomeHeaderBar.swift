//
//  HomeHeaderBar.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/4/22.
//

import UIKit

protocol HeaderBarDelegate{
    func backButtonTapped()
    
}

// the top view of our HomeView and store pages
// has two modes: .home and .subview
// both modes contain a search bar
class HomeHeaderBar: UIView {

    // the main title of our view, is our welcome text when a home view
    private let mainTitleLabel = UILabel()

    // the address view that is shown when in homePage mode
    private let addressLabel = UILabel()


    public var delegate: HeaderBarDelegate!

    init(type: TitleType){
        super.init(frame: .zero)
        setUpViews(type: type)
    }
    
    
    
    @objc func backButtonPressed(){
        delegate.backButtonTapped()
    }
 
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum TitleType{
    case home
    case subview
}

// MARK: Layout
extension HomeHeaderBar{
    
    
    // sets up our views based on our header type
    private func setUpViews(type: TitleType){
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back_arrow_icon"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchDown)
        if(type != .home){
            backButton.tintColor = .black
            addsView(backButton)
            NSLayoutConstraint.activate([
                backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                backButton.topAnchor.constraint(equalTo: topAnchor),
                backButton.heightAnchor.constraint(equalToConstant: 34),
                backButton.widthAnchor.constraint(equalToConstant: 34)
            ])
        }
        addsView(mainTitleLabel)
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: topAnchor),
        ])
        
        let leadingTitleAnchor = type == .home ? mainTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor) : mainTitleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20)
        
        leadingTitleAnchor.isActive = true
        
        
        switch type{
            case .home:
            // if its a home view show welcoe text and delivery address selection
                setTitleForHome()
                addAddressLabel()
            
            case .subview:
            // if it's a subtitle, show back button and title
                setTitleForSubview(subtitle: "Produce")
        }
        
        // adds search bar
        addSearchBar(type: type)
        
    }
    
    
    
    // adds our delivery address picker
    // is hidden when headerView is in subview mode
    private func addAddressLabel(){
        let subFont = UIFont(name: ProjectThemes.regularDMSans, size: 14)
        addressLabel.text = "address         -"
        addressLabel.font = subFont
        addressLabel.textColor = .lightGray
        addressLabel.sizeToFit()
        addsView(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
    }
    
    // adds our searchBar
    private func addSearchBar(type: TitleType){
        let topAnchorConstant = type == .home ? addressLabel.bottomAnchor : mainTitleLabel.bottomAnchor
        
        let searchView = SearchBarView()
        addsView(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: topAnchorConstant, constant: 20.0),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // sets our title label with our home setting
    private func setTitleForHome(){
        
        
        let font = UIFont(name: ProjectThemes.regularDMSans, size: 17)
        mainTitleLabel.font = font
        mainTitleLabel.textColor = ProjectThemes.greenGradientDark
        mainTitleLabel.sizeToFit()
        mainTitleLabel.text = "Hi, Alexandria"
    }
    
    // makes the title bold and large for our subtitle view
    private func setTitleForSubview(subtitle: String){
        let boldFont = UIFont(name: ProjectThemes.boldDMSans, size: 22)
        mainTitleLabel.font = boldFont
        mainTitleLabel.textColor = .black
        mainTitleLabel.sizeToFit()
        mainTitleLabel.text = subtitle
    }
    
}
