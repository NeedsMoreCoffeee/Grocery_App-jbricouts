//
//  ProductSearchView.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/12/22.
//

import UIKit

class ProductSearchView: UIView {

    private var heaaderView: HomeHeaderBar!
    
    // collection view that holds our catagories.
    private lazy var productSearchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        layout.minimumLineSpacing = 25
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    

    let product = ["Apple", "Mango", "Orange", "Banana", "Grapes", "Lemon", "Apple", "Mango", "Orange", "Banana", "Grapes", "Lemon"]
    
    private let productViewCellHeight: CGFloat = 176
    
    private let productViewCellWidth: CGFloat = 144

    private var catagoryTitle : UILabel!

    public var backButtonTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func showInspectionView(){
        let productView = ProductView()
        addsView(productView)
        NSLayoutConstraint.activate([
            productView.topAnchor.constraint(equalTo: topAnchor),
            productView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}


extension ProductSearchView:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CatagorySliderDelegate, HeaderBarDelegate{
   
    func backButtonTapped() {
        (backButtonTap ?? {})()
    }
    
  
    func catagoryTapped(withIndexPath indexPath: Int, withCatagoryName: String) {
        catagoryTitle.text = withCatagoryName
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        }
    
    // set the height of our catagory view cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: productViewCellWidth, height: productViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductSearchCell.reuseIdentifier, for: indexPath) as! ProductSearchCell
        cell.setCellProduct(name: product[indexPath.row])
        
        return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        showInspectionView()
    }
    
  
    
    
    
}


// MARK: Layout
extension ProductSearchView{
    private func setUpView(){
        self.alpha = 0
        createHeaderBar()
        addCatagoryCollectionView()
        
    }
    
    private func createHeaderBar(){
        backgroundColor = ProjectThemes.homeLightGrayColor

        // add the header view to scene
        heaaderView = HomeHeaderBar(type: .subview)
        heaaderView.delegate = self
        heaaderView.backgroundColor = .clear
        addsView(heaaderView)
        NSLayoutConstraint.activate([
            heaaderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            heaaderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            heaaderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            heaaderView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    func createCatagorySlider() -> CatagorySlider{
        // add the header view to scene
        let slider = CatagorySlider()
        addsView(slider)
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: heaaderView.bottomAnchor),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor),
            slider.heightAnchor.constraint(equalToConstant: 53)
        ])
        
        return slider
    }
    
    private func addCatagoryCollectionView(){
        
        let slider = createCatagorySlider()
        slider.delegate = self
        
        catagoryTitle = UILabel()
        catagoryTitle.text = "Fruits"
        catagoryTitle.font = UIFont(name: ProjectThemes.boldDMSans, size: 17)
        catagoryTitle.sizeToFit()
        addsView(catagoryTitle)
        NSLayoutConstraint.activate([
            catagoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 25),
            catagoryTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            catagoryTitle.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 15),
            catagoryTitle.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        productSearchCollectionView.backgroundColor = .clear
        addsView(productSearchCollectionView)
        NSLayoutConstraint.activate([
            productSearchCollectionView.topAnchor.constraint(equalTo: catagoryTitle.bottomAnchor),
            productSearchCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productSearchCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productSearchCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
        
        
        productSearchCollectionView.register(ProductSearchCell.self, forCellWithReuseIdentifier: ProductSearchCell.reuseIdentifier)
        
        bringSubviewToFront(catagoryTitle)
    }
    
}
