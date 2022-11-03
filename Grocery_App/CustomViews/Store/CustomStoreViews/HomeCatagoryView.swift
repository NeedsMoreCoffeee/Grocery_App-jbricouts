//
//  HomeCatagoryView.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/5/22.
//

import UIKit


protocol CatagoryMenuDelegate{
    func catagoryTapped(catagoryTapped catagory: ProductsController.ProductCatagories)
}
// the initial 'store' page of our app
class HomeCatagoryView: UIView {

    // collection view that holds our catagories.
    private lazy var catagoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        layout.minimumLineSpacing = 25
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private var producstController: ProductsController?
    
    private let catagoryViewCellHeight: CGFloat = 144
    
    // cell id for our collection view cells
    private let catagoryCellId = "catagory_collection_view_cell_id"
    
    private let defaultCellId = "default_cellId"

    public var delegate: CatagoryMenuDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    public func setProductsController(productsController: ProductsController){
        self.producstController = productsController
    }

    required init?(coder: NSCoder) {
        fatalError("Failied to implement coder")
    }
}


// MARK: CollectionView, Delegates and protocols
extension HomeCatagoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        }
    
    // set the height of our catagory view cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: catagoryViewCellHeight, height: catagoryViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (producstController?.getCatagories().count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: catagoryCellId, for: indexPath) as! CatagoryCollectionViewCell
        
        cell.setCatagory(catagory: (producstController?.getCatagories()[indexPath.row])!)
        
        return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CatagoryCollectionViewCell
        delegate.catagoryTapped(catagoryTapped: cell.getCatagory())
    }
    
    
}





// MARK: Layout
// adds layout, containing our catagories in a custom scroll bar,

extension HomeCatagoryView{
    
   private func setUpView(){
       addCatagoryCollectionView()
    }
    
    private func addCatagoryCollectionView(){
        catagoryCollectionView.backgroundColor = .clear
        addFullView(catagoryCollectionView, parent: self)
        catagoryCollectionView.register(CatagoryCollectionViewCell.self, forCellWithReuseIdentifier: catagoryCellId)
        catagoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: defaultCellId)
        
    }
    
    
    private func centerCellInsets() -> UIEdgeInsets{
        
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setUpSelectionView(){
        let searchView = UIView()
        searchView.backgroundColor = .red
        self.addFullView(searchView, parent: self)
        
    }
    
    
}

