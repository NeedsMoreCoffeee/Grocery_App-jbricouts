//
//  CatagorySlider.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/12/22.
//

import UIKit

protocol CatagorySliderDelegate{
    func catagoryTapped(withIndexPath indexPath:Int, withCatagoryName: String)
    
}

class CatagorySlider: UIView {
    
    
    private let catagories: [String] = ["Error", "Error", "Error", "Error"]
    
    private var catagoryButtons: [UIButton]!
    
    private var indexPath: Int = 0
    
    public var delegate: CatagorySliderDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        
        
    }
    
    public func setSliderTitles(titles: [String]){
        for titleButton in catagoryButtons{
            titleButton.removeFromSuperview()
        }
        indexPath = 0
        createCatagoryButtons(titles: titles)
    }
   
    
   @objc private func tappedCatagoryButton(sender: UIButton){
       deselectButton(button: catagoryButtons[indexPath])
       setButtonActive(button: sender)
       indexPath = sender.tag
       
       delegate.catagoryTapped(withIndexPath: indexPath, withCatagoryName: catagories[indexPath])
    }
    
    private func setButtonActive(button:UIButton){
        UIView.animate(withDuration: 0.2, animations: {
            button.backgroundColor = ProjectThemes.greenGradientDark
            button.setTitleColor(.white, for: .normal)
            button.layer.borderColor = UIColor.clear.cgColor
            button.titleLabel?.font = UIFont(name: ProjectThemes.boldDMSans, size: 14)
        })
  

    }
    
    private func deselectButton(button:UIButton){
        UIView.animate(withDuration: 0.2, animations: {
            button.backgroundColor = .clear
            button.setTitleColor(.systemGray, for: .normal)
            button.layer.borderColor = UIColor.clear.cgColor
            button.layer.borderColor = UIColor.systemGray.cgColor
            button.titleLabel?.font = UIFont(name: ProjectThemes.regularDMSans, size: 14)
            
        })
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("did not init coder")
    }

}



// MARK: Layout
extension CatagorySlider{
    
    private func setUpView(){
        createCatagoryButtons(titles: catagories)
        
        
    }
    
    private func createScrollView() -> UIScrollView{
        let scrollView = UIScrollView()
        addFullView(scrollView, parent: self)
        
        return scrollView
    }
    
    private func createCatagoryButtons(titles: [String]){
        
        let scrollView = createScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: 100 * CGFloat(catagories.count), height: 43.0)
        
        var trailingXInsert: NSLayoutXAxisAnchor?

        catagoryButtons = []
        
        for (index, catagory) in titles.enumerated(){
            
            if trailingXInsert == nil{
                trailingXInsert = scrollView.leadingAnchor
            }
            
            let isFirst = index == 0
            let constant:CGFloat =  isFirst ? 25 : 10
            let button = UIButton()
            button.layer.borderWidth = 0.5
            button.layer.cornerRadius = 12
            button.setTitle(catagory, for: .normal)
            button.tag = index
            isFirst ? setButtonActive(button: button) : deselectButton(button: button)
            scrollView.addsView(button)
            NSLayoutConstraint.activate([
                button.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                button.leadingAnchor.constraint(equalTo: trailingXInsert!, constant: constant),
                button.widthAnchor.constraint(equalToConstant: 83),
                button.heightAnchor.constraint(equalToConstant: 43)
            ])
            catagoryButtons.insert(button, at: index)
            button.addTarget(self, action: #selector(tappedCatagoryButton(sender:)), for: .touchDown)
            trailingXInsert = button.trailingAnchor
            
        }
        
        
        
    }
    
    
    
}
