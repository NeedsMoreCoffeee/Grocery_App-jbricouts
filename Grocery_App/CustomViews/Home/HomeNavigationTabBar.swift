//
//  HomeNavigationTabBar.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/5/22.
//

import UIKit

protocol HomeNavigationTabBarDelegate{
    func tabWasPressed( withIndexPath indexPath: Int)
}

// The bottom tab bar controller of our view.
// rests at the bottom of our home View Controller
class HomeNavigationTabBar: UIView {

    // all of our menu options
    private let tabBarTypes: [TabBarType] = [.store, .bag, .requests, .menu]
    
    
    // used to access in our base controller instead of creating a delegate
    public var tabTapped: ((_ tab: Int) -> Void)?
    
    /// the path of our tap, indicates the index in which our tab view was tapped
    private var indexPath: Int = 0
    
    public var delegate: HomeNavigationTabBarDelegate!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add our tabs
        addTabsToView(menuItems: tabBarTypes)
    
        // sets our first tab as selected
        self.activateTab(tab: 0)
        

    }
    
    // when a tab is pressed, switch it to a new page
    @objc private func handleTap(_ sender: UIGestureRecognizer) {
        
        if sender.view!.tag == indexPath {currentPathSelected(indexPath: indexPath); return }
        self.switchTab(from: self.indexPath, to: sender.view!.tag)
        delegate.tabWasPressed(withIndexPath: indexPath)
    }
    
    private func currentPathSelected(indexPath: Int){
        let tabToActivate = self.subviews[indexPath] as! CustomTabView
        tabToActivate.animateBounce(isSelected: true)

    }
    
    // deactivates old tab and activates new one
    private func switchTab(from: Int, to: Int) {
        self.deactivateTab(tab: from)
        self.activateTab(tab: to)
    }
    
    // activates the new view controller
    func activateTab(tab: Int) {
        // gets the subviews we have added. since our view is simple, we know only our tabs are our subviews.
        let tabToActivate = self.subviews[tab] as! CustomTabView
        
        // change the view in background, then animate the layouts if needed
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction], animations: {
            // here is where we want to do animations for our tabs.
                tabToActivate.isSelected(true)   // place holder
                
                tabToActivate.setNeedsLayout()
                tabToActivate.layoutIfNeeded()
            })
            // this is the referance to our higher function
            self.tabTapped?(tab)
            tabToActivate.animateBounce(isSelected: true)
        }
        
        // set the new indexPath to the new tab selected
        self.indexPath = tab
    }
    
    // deactivates a tab.
    func deactivateTab(tab: Int) {
        let inactiveTab = self.subviews[tab] as! CustomTabView
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction], animations: {
            // here is where we want to do animations for our tabs.
                
                inactiveTab.setNeedsLayout()
                inactiveTab.layoutIfNeeded()
            })
            
            // change the previous tab image right away without waiting for animations
            inactiveTab.isSelected(false)

        }
    }
    // adds the tabs to view
   private func addTabsToView(menuItems: [TabBarType]){
        // this is used to set our tabs leading anchors
        var leadingAnchorConstraint: NSLayoutXAxisAnchor?
        
        // this creates the first anchor, then will be set after each button has been made
            // so that the next tab button will always start right after the previous
        if leadingAnchorConstraint == nil{
            leadingAnchorConstraint = leadingAnchor
        }
        
       // the screen size, used to calculate button sizes and spacing
       let screenSize = UIScreen.main.bounds.width
       
       // used to scale our buttons closer. set to 0 for even spacing
       let spaceingOnSides = screenSize / 5
       
        // iterate through our CustomTabItems and create a tab for each
        for i in 0 ..< menuItems.count {
            // divide the width by the amount of items we have to ensure all of them fit the view with equal spacing
            let itemWidth = (screenSize - spaceingOnSides) / CGFloat(menuItems.count)
            
            // creates our tab item view.
            let itemView = CustomTabView(item: menuItems[i]) //self.createTabItem(item: menuItems[i])
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.tag = i
            
            // set constraints
            self.addSubview(itemView)
            NSLayoutConstraint.activate([
                itemView.widthAnchor.constraint(equalToConstant: itemWidth ),
                itemView.leadingAnchor.constraint(equalTo: leadingAnchorConstraint!, constant: spaceingOnSides / CGFloat(menuItems.count + 1)),
                itemView.topAnchor.constraint(equalTo: self.topAnchor),
                itemView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            // sets the leading anchor to the trailing anchor of our previous view.
            leadingAnchorConstraint = itemView.trailingAnchor
            
            // allows us to tap our views, essentially turning them into buttons
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        }
        
    }
    
    func setUpViews(){
      
        
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }
    

}


// MARK: Custom TabBar View

private class CustomTabView: UIView{
    // the icon view of our tab bar
    private let itemIconView = UIImageView()
    
    // the label of our tab bar
    private let itemTitleLabel = UILabel()

    // the tab item associated with this view
    private var tabItem: TabBarType!
    
    
    init(item: TabBarType) {
        super.init(frame: .zero)
        tabItem = item
        setUpView(item: item)
        
    }
    
    // this animates a bounce when pressed
    public func animateBounce(isSelected: Bool){
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            self.itemIconView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }) { _ in
            self.itemIconView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.changeImage(isSelected: isSelected)
        }
        
    }
    
    // called when the tab is selected.
    public func isSelected(_ isSelected: Bool = false){
       // was used for testing
       backgroundColor = isSelected ? .clear : .clear
       changeImage(isSelected: isSelected)
    }
    
    // changes the image of our image view
    private func changeImage(isSelected: Bool){
        let selectedColor = isSelected ? ProjectThemes.greenGradientDark : UIColor.lightGray
        itemIconView.tintColor = selectedColor
        itemTitleLabel.textColor = selectedColor
    }
   
   // Layout
    private func setUpView(item: TabBarType){

        backgroundColor = .clear

        addSubview(itemIconView)
        let image = item.icon.withRenderingMode(.alwaysTemplate)
        itemIconView.image = image
        itemIconView.tintColor = UIColor.lightGray
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        
        
        NSLayoutConstraint.activate([
            itemIconView.heightAnchor.constraint(equalToConstant: 20),
            itemIconView.widthAnchor.constraint(equalToConstant: 20),
            itemIconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemIconView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            ])
        
        
        let font = UIFont(name: ProjectThemes.mediumDMSans, size: 11)
        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.font = font
        itemTitleLabel.textColor = UIColor.lightGray
        itemTitleLabel.sizeToFit()
        addsView(itemTitleLabel)
        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: itemIconView.bottomAnchor, constant: 5),
            itemTitleLabel.centerXAnchor.constraint(equalTo: itemIconView.centerXAnchor)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// a custom enum that controls our tab bar mmenu items
public enum TabBarType: String, CaseIterable{
    case store = "Store"
    case bag = "Bag"
    case requests = "Requests"
    case menu = "Menu"
    
    /// the icon associated with our enum
    var icon: UIImage {
        switch self {
        case .store:
            return UIImage(named: "home_icon")!
        case .bag:
            return UIImage(named: "bag_icon")!
        case .requests:
            return UIImage(named: "requests_icon")!
        case .menu:
            return UIImage(named: "profile_icon")!
        }
    }
    
    /// the raw value and title of our enum
    var displayTitle: String {
            return self.rawValue.capitalized(with: nil)
        }
        
     
}


