//
//  RequestsViewBaseCell.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/22/22.
//

import UIKit

class RequestsViewBaseCell: UICollectionViewCell {
    static let reuseIdentifier = "requestsViewBaseCellID"

    
    private var collapsableTableView: UITableView!
    
    let colors: [(color: String, colors: [UIColor])] = [("Blues" ,[.systemCyan, .systemBlue, .systemPurple]), ("Reds", [.systemRed, .systemPink]), ("Greens", [.systemGreen, .systemTeal, .systemMint])]
    
    var hiddenSections = Set<Int>()
    
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hiddenSections.insert(0)
        hiddenSections.insert(1)
        hiddenSections.insert(2)

        addTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func headerTapped(sender:UIButton){
        let section = sender.tag
         
         func indexPathsForSection() -> [IndexPath] {
             var indexPaths = [IndexPath]()
             
             for row in 0..<self.colors[section].colors.count {
                 indexPaths.append(IndexPath(row: row,
                                             section: section))
             }
             
             return indexPaths
         }
         
         if self.hiddenSections.contains(section) {
             self.hiddenSections.remove(section)
             self.collapsableTableView.insertRows(at: indexPathsForSection(),
                                       with: .fade)
         } else {
             self.hiddenSections.insert(section)
             self.collapsableTableView.deleteRows(at: indexPathsForSection(),
                                       with: .fade)
         }
    }

}


extension RequestsViewBaseCell: UITableViewDelegate, UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section){
            return 0
        }
        return colors[section].colors.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollapsableTableViewCell.reuseIdentifier) as! CollapsableTableViewCell
      
       // cell.backgroundColor = colors[indexPath.section].colors[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
        return createHeaderView(section: section)
    }
    
    
    
    
    
}

// MARK: Layout
extension RequestsViewBaseCell{
    
    private func addTableView(){
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Requests"
        titleLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 22)
        titleLabel.sizeToFit()
        addsView(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 48)
        ])
        
        
        collapsableTableView = UITableView(frame: .zero, style: .grouped)
        collapsableTableView.delegate = self
        collapsableTableView.dataSource = self
        collapsableTableView.separatorStyle = .none
        addSubview(collapsableTableView)
        collapsableTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collapsableTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collapsableTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collapsableTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collapsableTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        collapsableTableView.register(CollapsableTableViewCell.self, forCellReuseIdentifier: CollapsableTableViewCell.reuseIdentifier)
        
        
    }
    
    
    private func createHeaderView(section: Int) -> UIView{
        
        let headerView = UIButton()
        headerView.tag = section
        
        let customContentView = UIView()
        
        let productImageView = UIImageView()
        let productNameLabel = UILabel()
        let productCostLabel = UILabel()
        
        customContentView.isUserInteractionEnabled = false
        
        customContentView.backgroundColor = .white
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 14
        headerView.addsView(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            customContentView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
            customContentView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -32),
            customContentView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 32),

        ])
        
        let productContainer = UIView()
        let imageColor = ProjectThemes.greenGradientLight
        
        productContainer.backgroundColor = imageColor.withAlphaComponent(0.12)
        productContainer.layer.cornerRadius = 12
        customContentView.addsView(productContainer)
        NSLayoutConstraint.activate([
            productContainer.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 20),
            productContainer.centerYAnchor.constraint(equalTo: customContentView.centerYAnchor),
            productContainer.heightAnchor.constraint(equalToConstant: 40),
            productContainer.widthAnchor.constraint(equalToConstant: 40)
        ])

        productImageView.image = UIImage(named: "box_icon")
        productImageView.tintColor = ProjectThemes.greenGradientDark
        productContainer.addsView(productImageView)
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: productContainer.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: productContainer.topAnchor),
            productImageView.heightAnchor.constraint(equalTo: productContainer.heightAnchor),
            productImageView.widthAnchor.constraint(equalTo: productContainer.widthAnchor)
        ])


        productNameLabel.text = "July 1st"
        productNameLabel.textColor = .darkGray
        productNameLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        productNameLabel.sizeToFit()
        customContentView.addsView(productNameLabel)
        NSLayoutConstraint.activate([
            productNameLabel.bottomAnchor.constraint(equalTo: customContentView.centerYAnchor, constant: -3),
            productNameLabel.leadingAnchor.constraint(equalTo: productContainer.trailingAnchor, constant: 15)

        ])

        productCostLabel.text = "$198.09"
        productCostLabel.textColor = ProjectThemes.greenGradientDark
        productCostLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 13)
        productCostLabel.sizeToFit()
        customContentView.addsView(productCostLabel)
        NSLayoutConstraint.activate([
            productCostLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 7),
            productCostLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor)

        ])

        headerView.addTarget(self, action: #selector(headerTapped(sender:)), for: .touchDown)

    
        return headerView
        
    }
    
    
}

// MARK: TableViewCell
private class CollapsableTableViewCell: UITableViewCell{
    static let reuseIdentifier = "CollapsableTableViewCellID"
    
    
    let customContentView = UIView()
    
    let productImageView = UIImageView()
    let productNameLabel = UILabel()
    let productCostLabel = UILabel()
    
    let guideBar = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpView(){
        backgroundColor = .clear
        
        customContentView.backgroundColor = .white
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 14
        contentView.addsView(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            customContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 52),

        ])
        
        productImageView.backgroundColor = .white
        productImageView.image = UIImage(named: "mango3_img")
        customContentView.addsView(productImageView)
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: customContentView.topAnchor),
            productImageView.heightAnchor.constraint(equalTo: customContentView.heightAnchor),
            productImageView.widthAnchor.constraint(equalTo: customContentView.heightAnchor)
        ])
        
        
        productNameLabel.text = "Mango"
        productNameLabel.textColor = .darkGray
        productNameLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        productNameLabel.sizeToFit()
        customContentView.addsView(productNameLabel)
        NSLayoutConstraint.activate([
            productNameLabel.bottomAnchor.constraint(equalTo: customContentView.centerYAnchor, constant: -3),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 2)

        ])
        
        productCostLabel.text = "$18.09"
        productCostLabel.textColor = ProjectThemes.greenGradientDark
        productCostLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 13)
        productCostLabel.sizeToFit()
        customContentView.addsView(productCostLabel)
        NSLayoutConstraint.activate([
            productCostLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 7),
            productCostLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor)

        ])
        
        
        guideBar.backgroundColor = ProjectThemes.greenGradientLight
        addsView(guideBar)
        NSLayoutConstraint.activate([
            guideBar.heightAnchor.constraint(equalTo: heightAnchor),
            guideBar.widthAnchor.constraint(equalToConstant: 2),
            guideBar.trailingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: -10),
            guideBar.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    
}
