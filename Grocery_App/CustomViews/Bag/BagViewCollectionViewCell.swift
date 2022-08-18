//
//  BagViewCollectionViewCell.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/17/22.
//

import UIKit

private struct Item{
    var name: String = "Mango"
    var cost: Float = 0.01
    var amoint: Int = 1
}

class BagViewCollectionViewCell: UICollectionViewCell {
    
    
    enum BagSection: String, CaseIterable{
        case address = "Address"
        case coupon = "Coupon"
        case items = "Items"
        case total = "Total"
        
        
    }
    static public let reuseIdentifier = "bagCVcellID"
    
    private var bagTableView: UITableView!
    
    private let items = [Item(), Item(), Item()]
    
    private let bagSections: [BagSection] = [.address, .coupon, .items, .total]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("")
        
    }
    
    
}


//MARK: Delegates
extension BagViewCollectionViewCell: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeader(title: bagSections[section].rawValue)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = bagSections[indexPath.section]
        if cellType == .total { return 150 }
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {return items.count}
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!

        let cellType = bagSections[indexPath.section]
        switch cellType{
        case .address:
            cell = tableView.dequeueReusableCell(withIdentifier: BagViewAddressTableCell.reuseIdentifier, for: indexPath) as! BagViewAddressTableCell
            
        case .coupon:
            cell = tableView.dequeueReusableCell(withIdentifier: BagViewCouponTableCell.reuseIdentifier, for: indexPath) as! BagViewCouponTableCell

        case .items:
            cell = tableView.dequeueReusableCell(withIdentifier: BagViewItemsTableCell.reuseIdentifier, for: indexPath) as! BagViewItemsTableCell
            cell.selectionStyle = .none
            
        case .total:
            cell = tableView.dequeueReusableCell(withIdentifier: BagViewTotalTableCell.reuseIdentifier, for: indexPath) as! BagViewTotalTableCell
          
        }
        
         
         return cell
    }
    
    
    
}



//MARK: Layout
extension BagViewCollectionViewCell{
    
    private func setUpView(){
        addBagViewTableView()
        
    }
    
    
    private func addBagViewTableView(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Bag"
        titleLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 22)
        titleLabel.sizeToFit()
        addsView(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 48)
        ])
        
        
        let totalView = UIView()
        addsView(totalView)
        NSLayoutConstraint.activate([
            totalView.bottomAnchor.constraint(equalTo: bottomAnchor),
            totalView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            totalView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            totalView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        
        let seperator = UIView()
        seperator.backgroundColor = .systemGray
        seperator.alpha = 0.7
        totalView.addsView(seperator)
        NSLayoutConstraint.activate([
            seperator.topAnchor.constraint(equalTo: totalView.topAnchor),
            seperator.leadingAnchor.constraint(equalTo: totalView.leadingAnchor),
            seperator.trailingAnchor.constraint(equalTo: totalView.trailingAnchor),
            seperator.heightAnchor.constraint(equalToConstant: 1)


        ])
        
        
        let totalFixedLabel = UILabel()
        totalFixedLabel.text = "Total"
        totalFixedLabel.font = UIFont(name: ProjectThemes.regularDMSans, size: 13)
        totalFixedLabel.textColor = .systemGray
        totalFixedLabel.sizeToFit()
        totalView.addsView(totalFixedLabel)
        NSLayoutConstraint.activate([
            totalFixedLabel.leadingAnchor.constraint(equalTo: totalView.leadingAnchor),
            totalFixedLabel.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 10)
        ])
        
        
        let totalAmountLabel = UILabel()
        totalAmountLabel.text = "$72.03"
        totalAmountLabel.font = UIFont(name: ProjectThemes.mediumDMSans, size: 13)
        totalAmountLabel.sizeToFit()
        totalView.addsView(totalAmountLabel)
        NSLayoutConstraint.activate([
            totalAmountLabel.trailingAnchor.constraint(equalTo: totalView.trailingAnchor),
            totalAmountLabel.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 10)
        ])
        
        let continueButton = GradientView(isVertical: false)
        continueButton.layer.cornerRadius = 16
        continueButton.clipsToBounds = true
        totalView.addsView(continueButton)
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: totalView.trailingAnchor, constant: -32),
            continueButton.heightAnchor.constraint(equalToConstant: 55),

        ])
        
        let continueButtonLabel = UILabel()
        continueButtonLabel.text = "Continue"
        continueButtonLabel.textColor = .white
        continueButtonLabel.textAlignment = .center
        continueButtonLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 14)
        continueButton.addFullView(continueButtonLabel, parent: continueButton)
        
        bagTableView = UITableView(frame: .zero, style: .grouped)
        bagTableView.separatorColor = .clear
        bagTableView.backgroundColor = .clear
        bagTableView.delegate = self
        bagTableView.dataSource = self
        addsView(bagTableView)
        NSLayoutConstraint.activate([
            bagTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bagTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bagTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bagTableView.bottomAnchor.constraint(equalTo: totalView.topAnchor)
        ])
        bagTableView.register(BagViewTableCell.self, forCellReuseIdentifier: BagViewTableCell.reuseIdentifier)
        bagTableView.register(BagViewItemsTableCell.self, forCellReuseIdentifier: BagViewItemsTableCell.reuseIdentifier)
        bagTableView.register(BagViewAddressTableCell.self, forCellReuseIdentifier: BagViewAddressTableCell.reuseIdentifier)
        bagTableView.register(BagViewCouponTableCell.self, forCellReuseIdentifier: BagViewCouponTableCell.reuseIdentifier)
        bagTableView.register(BagViewTotalTableCell.self, forCellReuseIdentifier: BagViewTotalTableCell.reuseIdentifier)


    }
    


    
    private func createHeader(title: String)->UIView{
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 17)
        titleLabel.sizeToFit()
        headerView.addsView(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 32),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5)
        ])
        
        
        return headerView
        
    }
}
