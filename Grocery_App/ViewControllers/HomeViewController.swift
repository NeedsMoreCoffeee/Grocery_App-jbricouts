//
//  HomeViewController.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/3/22.
//

import UIKit


// controls the logged in functionality of our app and navigation
// contains our HomeNavigationTabBar
class HomeViewController: UIViewController {

    // collection view that holds our catagories.
    private var homeNavigationCollectionView: UICollectionView!
    
    // the navigation bar used to switch between views
    private var homeNavigationTabBar: HomeNavigationTabBar!

    // the height of our custom tab bar
    private let customTabBarHeight = 77.0
    
    // all of our menu options
    private let tabBarTypes: [TabBarType] = [.store, .bag, .requests, .menu]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
     
    }
    
  
}

// MARK: Delegates and protocols
extension HomeViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeNavigationTabBarDelegate{
    
    // change our view when the tab bar is pressed
    func tabWasPressed(withIndexPath indexPath: Int) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear){
            self.homeNavigationCollectionView.contentOffset.x = CGFloat(indexPath) * UIScreen.main.bounds.width
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let path = collectionView.bounds
        let inset = collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom

        return CGSize(width: path.width, height: path.height - inset)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell!

        let cellType = tabBarTypes[indexPath.row]
        switch cellType{
        case .store:
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreViewBaseCell.reuseIdentifier, for: indexPath) as! StoreViewBaseCell
        case .bag:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: BagViewCollectionViewCell.reuseIdentifier, for: indexPath) as! BagViewCollectionViewCell
           // let cellRef = cell as! BagViewCollectionViewCell


        case .requests:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlankCollectionViewCell.reuseIdentifier, for: indexPath) as! BlankCollectionViewCell
            let cellRef = cell as! BlankCollectionViewCell
            cellRef.setText(string: cellType.rawValue)
        case .menu:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlankCollectionViewCell.reuseIdentifier, for: indexPath) as! BlankCollectionViewCell
            let cellRef = cell as! BlankCollectionViewCell
            cellRef.setText(string: cellType.rawValue)
   
        }
        
         
         return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    
    
}



// MARK: Layout
extension HomeViewController{
    
    private func setUpView(){
        createBottomTabBar()
        createCollectionView()
        view.bringSubviewToFront(homeNavigationTabBar)
    }
    
    
    private func createCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        homeNavigationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        homeNavigationCollectionView.isPagingEnabled = true
        homeNavigationCollectionView.delegate = self
        homeNavigationCollectionView.dataSource = self
        
        
        homeNavigationCollectionView.backgroundColor = ProjectThemes.homeLightGrayColor
        view.addsView(homeNavigationCollectionView)
        NSLayoutConstraint.activate([
            homeNavigationCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            homeNavigationCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeNavigationCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeNavigationCollectionView.bottomAnchor.constraint(equalTo: homeNavigationTabBar.topAnchor)
        ])
        homeNavigationCollectionView.register(StoreViewBaseCell.self, forCellWithReuseIdentifier: StoreViewBaseCell.reuseIdentifier)
        homeNavigationCollectionView.register(BagViewCollectionViewCell.self, forCellWithReuseIdentifier: BagViewCollectionViewCell.reuseIdentifier)

        homeNavigationCollectionView.register(BlankCollectionViewCell.self, forCellWithReuseIdentifier: BlankCollectionViewCell.reuseIdentifier)

    }
    
    // creates our bottom navigation bar - HomeNavigationTabBar - a custom tab view for navigating the app
    private func createBottomTabBar(){
        // add view to scene
        homeNavigationTabBar = HomeNavigationTabBar()
        homeNavigationTabBar.delegate = self
        homeNavigationTabBar.backgroundColor = .white
        view.addsView(homeNavigationTabBar)
        NSLayoutConstraint.activate([
            homeNavigationTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeNavigationTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeNavigationTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeNavigationTabBar.heightAnchor.constraint(equalToConstant: customTabBarHeight)

        ])
        
        
        // create a unique shadow at the top of the view.
        homeNavigationTabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
        homeNavigationTabBar.layer.shadowRadius = 5
        homeNavigationTabBar.layer.shadowOpacity = 0.1
        
    }
    
 
    
}

