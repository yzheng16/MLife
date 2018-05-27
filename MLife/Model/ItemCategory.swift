//
//  ItemCategory.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-25.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import UIKit

class ItemCategory: NSObject {
    var categoryName: String?
    var items: [Item]?
    
    init(categoryName: String, items: [Item]) {
        self.categoryName = categoryName
        self.items = items
    }
    
    static func sampleItemCategories() ->[ItemCategory]{
        let items = Item.sampleItems()
        
        let newCategory = ItemCategory(categoryName: "New", items: items)
        let nearbyCategory = ItemCategory(categoryName: "Nearby", items: items)
        return [newCategory, nearbyCategory]
    }
}
