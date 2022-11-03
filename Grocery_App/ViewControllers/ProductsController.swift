//
//  ProductController.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/25/22.
//
import UIKit

class ProductsController{
    
    struct Product: Hashable{
        let name: String
        let cost: Float
        let portion: String
        let imageName: String?
        var catagory: ProductCatagories?
        var subCatagory: String?
        
        let identifier = UUID()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func == (lhs: Product, rhs: Product) -> Bool{
            return lhs.identifier == rhs.identifier
        }
    }

    enum ProductCatagories: String{
        case new = "New"
        case produce = "Produce"
        case deli = "Deli"
        case frozen = "Frozen"
        case bakery = "Bakery"
        case dairy = "Dairy"
        case alchohol = "Alcohol"
        
        var catagoryImage: UIImage {
            switch self {
            case .new:
                return UIImage(named: "new_product_image")!
            case .produce:
                return UIImage(named: "produce_image")!
            case .deli:
                return UIImage(named: "deli_image")!
            case .frozen:
                return UIImage(named: "frozen_image")!
            case .bakery:
                return UIImage(named: "bread_image")!
            case .dairy:
                return UIImage(named: "dairy_image")!
            case .alchohol:
                return UIImage(named: "beer_image")!
            }
        }
    }
    
   private let catagories: [ProductCatagories] = [.new, .produce, .deli, .frozen, .bakery, .dairy, .alchohol]
    
   public var subCatagories: Dictionary<ProductCatagories, [String]> =  [.new: ["All"],
                                                                   .produce: ["All"],
                                                                   .deli: ["All"],
                                                                   .frozen: ["All"],
                                                                   .bakery: ["All"],
                                                                   .dairy: ["All"],
                                                                   .alchohol: ["All"]
                                                                ]
    
   private let products: [Product] = [
        Product(name: "Apple", cost: 1.99, portion: "150g", imageName: nil, catagory: .produce, subCatagory: "Fruits"),
        Product(name: "Banana", cost: 1.99, portion: "150g", imageName: nil, catagory: .produce, subCatagory: "Fruits"),
        Product(name: "Orange", cost: 1.99, portion: "150g", imageName: nil, catagory: .produce, subCatagory: "Fruits"),
        Product(name: "Mango", cost: 1.99, portion: "150g", imageName: nil, catagory: .produce, subCatagory: "Fruits"),
        Product(name: "Grapes", cost: 1.99, portion: "150g", imageName: nil, catagory: .produce, subCatagory: "Fruits"),
        Product(name: "PineApple", cost: 1.99, portion: "150g", imageName: nil, catagory: .produce, subCatagory: "Fruits"),
        Product(name: "Kiwi", cost: 1.99, portion: "150g", imageName: nil, catagory: .produce, subCatagory: "Fruits"),
        Product(name: "Strawberries", cost: 1.99, portion: "150g", imageName: nil, catagory: .produce, subCatagory: "Fruits"),
      
        Product(name: "Turkey Breast", cost: 1.99, portion: "150g", imageName: nil, catagory: .deli, subCatagory: "Sliced Meat"),
        Product(name: "Black Forrest Ham", cost: 1.99, portion: "150g", imageName: nil, catagory: .deli, subCatagory: "Sliced Meat"),
        Product(name: "Pastrami", cost: 1.99, portion: "150g", imageName: nil, catagory: .deli, subCatagory: "Sliced Meat"),
    
    
        Product(name: "Lasagnia", cost: 1.99, portion: "150g", imageName: nil, catagory: .frozen, subCatagory: "Meals"),
        Product(name: "Pizza", cost: 1.99, portion: "150g", imageName: nil, catagory: .frozen, subCatagory: "Meals"),
        
        Product(name: "White", cost: 1.99, portion: "150g", imageName: nil, catagory: .bakery, subCatagory: "Bread"),
        Product(name: "Wheat", cost: 1.99, portion: "150g", imageName: nil, catagory: .bakery, subCatagory: "Bread"),
        Product(name: "Sourdough", cost: 1.99, portion: "150g", imageName: nil, catagory: .bakery, subCatagory: "Bread"),
    
        Product(name: "Whole Milk", cost: 1.99, portion: "150g", imageName: nil, catagory: .dairy, subCatagory: "Milk"),
        Product(name: "No Fat Milk", cost: 1.99, portion: "150g", imageName: nil, catagory: .dairy, subCatagory: "Milk"),
        Product(name: "Chocolate Milk", cost: 1.99, portion: "150g", imageName: nil, catagory: .dairy, subCatagory: "Milk"),

        Product(name: "Carona", cost: 1.99, portion: "150g", imageName: nil, catagory: .alchohol, subCatagory: "Beer"),
        Product(name: "Dos XX", cost: 1.99, portion: "150g", imageName: nil, catagory: .alchohol, subCatagory: "Beer"),
        Product(name: "Modelo", cost: 1.99, portion: "150g", imageName: nil, catagory: .alchohol, subCatagory: "Beer"),




    ]
    
    init(){
        createSubCatagories()
        
    }
    
    public func getProducts() -> [Product]{
        return products
    }
    
    public func getCatagories() -> [ProductCatagories]{
        return catagories
    }
    
    private func createSubCatagories(){
        for product in products {
            if let mainCatagory = product.catagory{
                if let subCatagory = product.subCatagory{
                    if subCatagories[mainCatagory]!.contains(subCatagory){
                    } else {
                        subCatagories[mainCatagory]?.append(subCatagory)
                    }
                }
            }
          
           
        }
        
    }
    
    
}
