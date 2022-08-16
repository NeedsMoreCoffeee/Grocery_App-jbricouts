//
//  HomeCatagoryView.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/5/22.
//

import UIKit


protocol CatagoryMenuDelegate{
    func catagoryTapped(catagoryTapped catagory: String)
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
    
    
    private let catagoryViewCellHeight: CGFloat = 144
    
    // cell id for our collection view cells
    private let catagoryCellId = "catagory_collection_view_cell_id"
    
    private let defaultCellId = "default_cellId"

    public var delegate: CatagoryMenuDelegate!
    
    // an array of catagories that will be the foundation for our scroll view cells
    private let catagories = ["New", "Produce", "Deli Meats", "Frozen", "Bakery", "Dairy", "Alcohol", "Supplies" ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
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
        return catagories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: catagoryCellId, for: indexPath) as! CatagoryCollectionViewCell
        cell.setLabel(text: catagories[indexPath.row])
        
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



/*
 MARK: Old code: A custom scroll view with cells
 
 // in an effort to minimize code I've decided against a UICollectionView since the functionality is simple
 // *1 - room for improvement: ive noticed the more catagories there are, the mor bottom spacing created.
 
 // sets up the scroll view, which incapsulates our entire view
 let scrollView = UIScrollView()
 let amountOfCatagories:CGFloat = CGFloat(catagories.count)
 let advertisementHeight = 130.0
 let catagoryviewHeight = 144.0
 
 // *1
 // (advertisement spacing + advertisementHeight) + (catagoriesHeight) + (catagories spacing)
 let catagoryViewHeight = (50.0 + advertisementHeight) + (catagoryviewHeight * amountOfCatagories / 2) + (25.0 * CGFloat(amountOfCatagories + 2))
 
 // adds the scroll view which everything resides in
 scrollView.clipsToBounds = true
 scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: catagoryViewHeight)
 scrollView.backgroundColor = .clear
 addsView(scrollView)
 NSLayoutConstraint.activate([
     scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
     scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
     scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
     scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
 ])
 

 // a view with advertisements
 let advertisementView = UIView()
 advertisementView.backgroundColor = ProjectThemes.lightGreenSubTextColor
 advertisementView.layer.cornerRadius = 15
 scrollView.addsView(advertisementView)
 NSLayoutConstraint.activate([
     advertisementView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
     advertisementView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
     advertisementView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
     advertisementView.heightAnchor.constraint(equalToConstant: advertisementHeight)
     
 ])
 
 // stylize the view by adding a shadow
 advertisementView.addThematicShadow()
 
 
// createCatagoryViews(parent: scrollView, leadingAnchor: advertisementView, catagories: catagories) // example call

 Code used for an original custom scroll design, back when the functionality of this view was basic
 
 
 // creates the views of our catagories
 func createCatagoryViews(parent: UIView, leadingAnchor: UIView, catagories: [String]){
     
     // these keep track of which vertical heading to place our views
     var leftLeadingTopAnchor = leadingAnchor.bottomAnchor
     var rightLeadingTopAnchor = leadingAnchor.bottomAnchor

     // devides our array in half, one for the left of the view one for the right
     let split = catagories.count/2

     
     // iterate over all our catagories
     for (index, _) in catagories.enumerated(){
       
         // determines if our catagory will be on the left or right
         let isLeft = index < split
                     
         // sets our leading and trailing anchors
         let start = isLeft ? leadingAnchor.leadingAnchor : leadingAnchor.centerXAnchor
         let end = isLeft ? leadingAnchor.centerXAnchor : leadingAnchor.trailingAnchor
         
         // the spacing between out leading and trailing anchors
         let constantEnd = isLeft ? -12.5 : 0.0
         let constantStart = isLeft ? 0.0 : 12.5
                 
         // create and add the view
         let catagoryView = UIView()
         catagoryView.backgroundColor = .white
         catagoryView.layer.cornerRadius = 16
         catagoryView.tag = index
         parent.addsView(catagoryView)
         NSLayoutConstraint.activate([
             catagoryView.topAnchor.constraint(equalTo: isLeft ? leftLeadingTopAnchor : rightLeadingTopAnchor, constant:  25),
             catagoryView.leadingAnchor.constraint(equalTo: start, constant: constantStart),
             catagoryView.trailingAnchor.constraint(equalTo: end, constant:  constantEnd),
             catagoryView.heightAnchor.constraint(equalToConstant: 144)
             
         ])
         
         // stylize the view by adding a shadow
         catagoryView.addThematicShadow()
         
         // update where our views top anchors are
         if isLeft {leftLeadingTopAnchor = catagoryView.bottomAnchor}
         if !isLeft {rightLeadingTopAnchor = catagoryView.bottomAnchor}
         
     }
     
 }
 
 
 */
