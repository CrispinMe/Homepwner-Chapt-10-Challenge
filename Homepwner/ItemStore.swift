//
//  ItemStore.swift
//  Homepwner
//
//  Created by Crispin Lloyd on 20/04/2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    @discardableResult func createItem(requestRandom: Bool) -> Item {
        let newItem = Item(random: requestRandom)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    init(){
        for _ in 0..<5 {
            createItem(requestRandom: true)
        }
    }
}
