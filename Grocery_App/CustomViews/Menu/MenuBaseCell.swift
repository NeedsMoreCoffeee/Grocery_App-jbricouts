//
//  MenuBaseCell.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/23/22.
//

import UIKit


// MARK: MenuView
class MenuBaseCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MenuBaseCell"
    
    var titleLabel: UILabel!
    var menuImageView: UIImageView!
    var menuTableView: UITableView!

    let tableViewCellHeight: CGFloat = 55.0
    
    
    let menuTitlesArray = ["About Us", "Support", "Terms And Conditions", "Privacy Policy"]
    let imagesNameArray = ["info_icon", "heart_icon", "documents_icon", "documents_icon"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    
    
    // MARK: LAYOUT
    private func setUpView(){
        backgroundColor = .white
        addMenuTitle()
        addMenuImageAndTitle()
        addMenuTableView()
    }
    
    
    private func addMenuTitle(){
        titleLabel = UILabel()
        titleLabel.text = "Menu"
        titleLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 22)
        titleLabel.sizeToFit()
        addsView(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 48)
        ])
    }
    
    private func addMenuImageAndTitle(){
        let imageViewSize: CGFloat = 170
        menuImageView = UIImageView()
        menuImageView.layer.cornerRadius = imageViewSize / 2
        menuImageView.image = UIImage(named: "menu_icon")
        menuImageView.tintColor = ProjectThemes.greenGradientDark
        menuImageView.backgroundColor = ProjectThemes.greenGradientDark.withAlphaComponent(0.14)
        addsView(menuImageView)
        NSLayoutConstraint.activate([
            menuImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            menuImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuImageView.heightAnchor.constraint(equalToConstant: imageViewSize),
            menuImageView.widthAnchor.constraint(equalToConstant: imageViewSize)
        ])
        
        let enterLabel = UILabel()
        enterLabel.text = "Enter"
        enterLabel.textAlignment = .center
        enterLabel.textColor = ProjectThemes.greenGradientDark
        enterLabel.sizeToFit()
        enterLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 14)
        addsView(enterLabel)
        NSLayoutConstraint.activate([
            enterLabel.topAnchor.constraint(equalTo: menuImageView.bottomAnchor, constant: 10),
            enterLabel.centerXAnchor.constraint(equalTo: menuImageView.centerXAnchor)
        ])
    }
    
    private func addMenuTableView(){
        menuTableView = UITableView(frame: .zero, style: .grouped)
        menuTableView.backgroundColor = .white
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.separatorStyle = .none
        addsView(menuTableView)
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: menuImageView.bottomAnchor,constant: 27),
            menuTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        menuTableView.register(MenuTableCell.self, forCellReuseIdentifier: MenuTableCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("failed to init coder")
    }
}


extension MenuBaseCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableCell.reuseIdentifier, for: indexPath) as! MenuTableCell
        cell.setTitle(title: menuTitlesArray[indexPath.row], image: imagesNameArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewCellHeight
    }
    
}


// MARK: Table View Cell
private class MenuTableCell: UITableViewCell{
    
    static let reuseIdentifier = "MenuTableCellID"
    
    private var menuIcon: UIImageView!
    private var menuLabel: UILabel!
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    public func setTitle(title: String, image: String){
        menuLabel.text = title
        menuIcon.image = UIImage(named: image)
    }
    
    private func setUpView(){
        // add menu icon, label and arrow
        selectionStyle = .none
        let menuIconSize: CGFloat = 20
        
        menuIcon = UIImageView()
        menuIcon.backgroundColor = .clear
        menuIcon.tintColor = ProjectThemes.greenGradientDark
        addsView(menuIcon)
        NSLayoutConstraint.activate([
            menuIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            menuIcon.heightAnchor.constraint(equalToConstant: menuIconSize),
            menuIcon.widthAnchor.constraint(equalToConstant: menuIconSize)
        ])
        
        menuLabel = UILabel()
        menuLabel.text = "Menu Text"
        menuLabel.font = UIFont(name: ProjectThemes.regularDMSans, size: 14)
        menuLabel.sizeToFit()
        addsView(menuLabel)
        NSLayoutConstraint.activate([
            menuLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuLabel.leadingAnchor.constraint(equalTo: menuIcon.trailingAnchor, constant: 20)
        ])
        
        let rightArrowIcon = UIImageView(image: UIImage(named: "right_arrow_icon"))
        rightArrowIcon.tintColor = .black
        addsView(rightArrowIcon)
        NSLayoutConstraint.activate([
            rightArrowIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            rightArrowIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightArrowIcon.heightAnchor.constraint(equalToConstant: 15),
            rightArrowIcon.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
