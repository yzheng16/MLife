//
//  Item.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-14.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import UIKit

//struct Item {
//    let itemId: Int
//    let itemName: String
//    let userId: String
//    let itemPrice: Decimal
//    let date: Date
//    let place: String
//    let city: String
//    let numberOfLikes: Int
//    let status: Bool
//    let detail: String
//    let itemType: String //出售，租房，求购，换汇
//    let paymentType: String
//    let tradeType: String//面交，网交
//}

//struct Item {
//    let itemId: Int
//    let itemName: String
//    let user: User
//    let itemPrice: Decimal
//    let date: Date
//    let place: String
//    let city: String
//    let numberOfLikes: Int
//    let status: Bool
//    let detail: String
//    let itemType: String //出售，租房，求购，换汇
//    let paymentType: String
//    let tradeType: String//面交，网交
//    let itemImages: [ItemImage]
//}

//MARK: fix option type
class Item: NSObject {
    var itemId: Int?
    var itemName: String?
    var user: User?
    var itemPrice: Decimal?
    var date: Date?
    var place: String?
    var city: String?
    var numberOfLikes: Int?
    var status: Bool?
    var detail: String?
    var itemType: String? //出售，租房，求购，换汇
    var paymentType: String?
    var tradeType: String?//面交，网交
    //MARK: i am not sure
    var itemImages: [UIImage]? // or [ItemImage]
    
    init(name:String, user: User, price: Decimal, date: Date, place: String, city: String, numberOfLikes: Int, images: [UIImage]) {
        itemName = name
        self.user = user
        itemPrice = price
        self.date = date
        self.place = place
        self.city = city
        self.numberOfLikes = numberOfLikes
        itemImages = images
        
    }
    
    static func sampleItems() -> [Item] {
        let yiZheng = User(userId: "zsxzy@live.cn", profileImage: #imageLiteral(resourceName: "profile_image"), userName: "Yi Zheng")
        let kettle = Item(name: "Kettle", user: yiZheng, price: 999.99, date: Date(), place: "Southgate", city: "Edmonton", numberOfLikes: 3, images: [#imageLiteral(resourceName: "home-trade"), #imageLiteral(resourceName: "home-trade 2"), #imageLiteral(resourceName: "home-trade"), #imageLiteral(resourceName: "home-trade 2")])//1,2,1,2
        
        let bottle = Item(name: "Bottle", user: yiZheng, price: 99.99, date: Date(), place: "13746 38st", city: "Edmonton", numberOfLikes: 33, images: [#imageLiteral(resourceName: "home-trade 2"), #imageLiteral(resourceName: "home-trade")])//2,1
        return [kettle, bottle]
    }
}
