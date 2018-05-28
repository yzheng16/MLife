//
//  HomeDatasource.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-11.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents

class HomeDatasource: Datasource {
    
//    let items: [Item] = {
//        let yiZheng = User(userId: "zsxzy@live.cn", profileImage: #imageLiteral(resourceName: "profile_image"), userName: "Yi Zheng")
//        let itemImages = [ItemImage(imageCode: 1, image: #imageLiteral(resourceName: "home-trade"), itemId: 1),ItemImage(imageCode: 2, image: #imageLiteral(resourceName: "home-trade 2"), itemId: 1)]
//        let kettle = Item(itemId: 1, itemName: "Kettle", user: yiZheng, itemPrice: 9.99, date: Date(), place: "Southgate", city: "Alberta", numberOfLikes: 3, status: true, detail: "This is a simple kettle", itemType: "sell", paymentType: "cash", tradeType: "inPerson", itemImages: itemImages)
//        let bottle = Item(itemId: 2, itemName: "Bottle", user: yiZheng, itemPrice: 1.99, date: Date(), place: "38473 104st", city: "Alberta", numberOfLikes: 1, status: true, detail: "This is a ...", itemType: "sell", paymentType: "etransfer", tradeType: "inPerson", itemImages: itemImages)
//        return [kettle, bottle]
//    }()
    
    var itemCategories: [ItemCategory]?
    
    let articles: [Article] = {
        let yiZheng = User(userId: "zsxzy@live.cn", profileImage: #imageLiteral(resourceName: "profile_image"), userName: "Yi Zheng")
        let article1 = Article(title: "What is best resturant in Edmonton", user: yiZheng, numberOfViews: 78, content: "this is a random content of a article", time: Date(), location: "Edmonton, AB", numberOfComments: 2)
        return [article1]
    }()
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [ItemHeader.self, ArticleHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [SellingCell.self, ArticleCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return articles[indexPath.item]
        }else if indexPath.section == 0 {
            if let items = itemCategories?[indexPath.item] {
                return items
            }
            return 0
        }
        return 0
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [ItemFooter.self, ArticleFooter.self]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        //MARK: i should fix it
        itemCategories = ItemCategory.sampleItemCategories()
        if section == 1 {
            return articles.count
        }else if section == 0 {
//            if let count = items?.count{
//                return count
//            }
            return 1
        }
        return 0
    }
}
