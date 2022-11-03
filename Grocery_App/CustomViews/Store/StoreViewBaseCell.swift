//
//  StoreViewBaseCell.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/16/22.
//

import UIKit

class StoreViewBaseCell: UICollectionViewCell {
    let user: User = User(username: "Alexandra")
    
    private var heaaderView: HomeHeaderBar!
        
    private var searchViewLeadingAnchor: NSLayoutConstraint!
    
    private var searchView: ProductSearchView!

    static let reuseIdentifier = "storeBaseViewCellID"
    
    private var producstController: ProductsController?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setProductsController(productsController: ProductsController){
        self.producstController = productsController
        setUpViews()
        addSearchView()
    }
    
    private func showProductSearchView(){
        
        let isOpen = searchViewLeadingAnchor.constant < 0
        UIView.animate(withDuration: 0.2, animations: {
            self.searchView.alpha = isOpen ? 0 : 1.0
            self.searchViewLeadingAnchor.constant = isOpen ? 0 : -UIScreen.main.bounds.width
            self.layoutIfNeeded()
        })
    }
    
    private func setSearchViewCatagory(catagory: ProductsController.ProductCatagories){
        searchView.setCatagorySearch(catagory: catagory)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




// MARK: Delegates
extension StoreViewBaseCell: CatagoryMenuDelegate{
    
    func catagoryTapped(catagoryTapped catagory: ProductsController.ProductCatagories) {
        setSearchViewCatagory(catagory: catagory)
        showProductSearchView()
    }
    
}







// MARK: Layout: - add top view, content view and custom tab bar view
extension StoreViewBaseCell{
        
    // creates the header bar at the top of our view and the bottom tab bar
    private func setUpViews(){
        backgroundColor = ProjectThemes.homeLightGrayColor
        
        createHeaderBar()
        addContentView()
        
        
    }
    
    // create the top bar HomeHeaderBar.class, has two view modes: .home, .subview
    private func createHeaderBar(){
        // add the header view to scene
        heaaderView = HomeHeaderBar(type: .home)
        heaaderView.backgroundColor = .clear
        addsView(heaaderView)
        NSLayoutConstraint.activate([
            heaaderView.topAnchor.constraint(equalTo: topAnchor),
            heaaderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            heaaderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            heaaderView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    // the view which holds our content
    private func addContentView(){
        let catagoryScrollView = HomeCatagoryView()
        catagoryScrollView.setProductsController(productsController: producstController!)
        catagoryScrollView.backgroundColor = .clear
        addsView(catagoryScrollView)
        NSLayoutConstraint.activate([
            catagoryScrollView.topAnchor.constraint(equalTo: heaaderView.bottomAnchor),
            catagoryScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            catagoryScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            catagoryScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        catagoryScrollView.delegate = self
        
    }
    
  
   private func addSearchView(){
       searchView = ProductSearchView(productsController: self.producstController!)
        searchView.backButtonTap = showProductSearchView
        addsView(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: topAnchor),
            searchView.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchView.widthAnchor.constraint(equalTo: widthAnchor)
        
        ])
        
        searchViewLeadingAnchor = searchView.leadingAnchor.constraint(equalTo: trailingAnchor)
        searchViewLeadingAnchor.isActive = true
    }

    

    
    
}



