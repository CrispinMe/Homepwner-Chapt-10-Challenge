//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Crispin Lloyd on 18/04/2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    var twoArrays = [[Item]]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch(section) {
            
        case 0:
            return twoArrays[0].count
            
        default:
            return twoArrays[1].count
        }
        

    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        //Create array to hold itemStore.allItem array
        var pArray = Array<Item>()
        
        pArray = itemStore.allItems
        
        //Split items into 2 arrays, the first containing items > 50.00, the seccond containing items < 50.00
        twoArrays = createTwoArrays(pArray)
        
        //Creater footer for the tableView
        var tableFooter: UITextView
        
        let tableFooterFrame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
        tableFooter = UITextView(frame: tableFooterFrame)
        
        //Set text for tableFooter
        tableFooter.text = "No more items!"
        
        tableView.tableFooterView = tableFooter
        
        //Set the height of the rows in the table to 60 points
        tableView.rowHeight = 60
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("twoArrays.count= \(twoArrays.count)")

        return twoArrays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        //Set the text on the cell with the description of the item
        //that is at the nth index of items, where n = row for this cell
        //will appear in on the tableView
        
        var item: Item
        
        switch(indexPath.section) {
        case 0:
            item = twoArrays[0][indexPath.row]
            
        default:
            item = twoArrays[1][indexPath.row]
            
        }
        
        //Create font object with size set to 20 points
        var custCellFont: UIFont
        custCellFont = UIFont(name: "AppleSDGothicNeo-Medium", size:  20)!
        
        
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        //Apply custom font to cell
        cell.textLabel?.font = custCellFont
     
        return cell
    }
    
    
    
    //Function to separate allItems array into 2 arrays one for items worth less the 50 dollars and the other for items worth more than fifty dollars. Use tuple to return the two arrays
    func createTwoArrays(_ parentArray: [Item]) -> [[Item]] {
        var greaterAndLess = [[Item]]()
        var lessThanFifty = [Item]()
        var moreThanFifty = [Item]()
        
        for eachItem in parentArray {
            
            if eachItem.valueInDollars <     50 {
                lessThanFifty.append(eachItem)
                print(greaterAndLess)
            } else {
               moreThanFifty.append(eachItem)
            }
        }
        
        greaterAndLess.append(lessThanFifty)
        greaterAndLess.append(moreThanFifty)
        
        return (greaterAndLess)
    }
}
