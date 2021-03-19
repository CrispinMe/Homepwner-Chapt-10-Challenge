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
    
    //Create array to hold itemStore.allItem array
    var pArray = Array<Item>()
    
    var twoArrays = [[Item]]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if twoArrays.count > 0 {
            
        switch(section) {
            
        case 0:
            return twoArrays[0].count
            
        case 1:
            return twoArrays[1].count
            
        default:
            return twoArrays[2].count
            
            }
        
        }
        
        return 1
        

    }
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        
        pArray = itemStore.allItems

        
        
        //Check if the allItems property on the itemStore is empty or not; if it is empty then create an artificial item to indicate that there are no more items
        if itemStore.allItems.count == 0 {
            
        //Add additional row to indicate that there are no more items
        let noMoreItemsItem = itemStore.createItem(requestRandom: false)
        
        //Set the name text for the item to "No more items"
        noMoreItemsItem.name = "There are no items"
        
        //Add noMoreItemsItem to pArray
        pArray.append(noMoreItemsItem)
            
        } else {
        
        pArray = itemStore.allItems

        
        //Split items into 2 arrays, the first containing items > 50.00, the seccond containing items < 50.00
        twoArrays = createTwoArrays(pArray)
            
        }
        
        
        //Creater footer for the tableView
        //var tableFooter: UITextView
        
        //let tableFooterFrame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
        //tableFooter = UITextView(frame: tableFooterFrame)
        
        //Set text for tableFooter
        //tableFooter.text = "No more items!"
        
        //tableView.tableFooterView = tableFooter
        
        //Set the height of the rows in the table to 60 points
        //tableView.rowHeight = 60
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("twoArrays.count= \(twoArrays.count)")
        
        if twoArrays.count > 0 {

        return twoArrays.count
            
        } else {
            
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //Set the row height for the no more items row to 44 and all other rows to 60
        var rowHeight: CGFloat = CGFloat()
        
        if twoArrays.count == 0 {
            rowHeight = 44
        } else if indexPath.section == 2 {
            rowHeight = 44
                
        } else {
            rowHeight = 60
        }
        
        return rowHeight
        
    }
    
    //override func tableView(_ tableView: UITableView,
                            //heightForHeaderInSection section: Int) -> CGFloat {
       //var headerHeight = CGFloat()
        
        //if twoArrays.count > 0 {
            
        //switch(section) {

        //case 0:
            //headerHeight = 40.0
            
        //case 1:
            //headerHeight = 40.0


            
        //default:
            //headerHeight = 0

            //}
            
        //} else {
            
            //headerHeight = 0
        //}

        
        //return headerHeight
            
        
    //}
    
    //override func tableView(_ tableView: UITableView,
                            //viewForHeaderInSection section: Int) -> UIView? {
        //let headerLabel: UILabel
        //headerLabel = UILabel()

        //if twoArrays.count > 0 {
        
        
        //headerLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size:  20)!
        //headerLabel.textColor = .blue
        
        //switch(section) {
        //case 0:
            //headerLabel.text = "Items less than fifty"
            
        //case 1:
            //headerLabel.text = "Items greater than fifty"

            
        //default:
            //headerLabel.text = ""
            
            //}
            
        //} else {
            
            //headerLabel.text = ""
        //}
            
            
        
        //return headerLabel

    //}
    
    //override func tableView(_ tableView: UITableView,
                            //heightForFooterInSection section: Int) -> CGFloat {
        //var footerHeight = CGFloat()
        //footerHeight = 20.0
        
        //return footerHeight
    //}
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        //Set the text on the cell with the description of the item
        //that is at the nth index of items, where n = row for this cell
        //will appear in on the tableView
        
        var item: Item
        
        if twoArrays.count > 0 {
            
        switch(indexPath.section) {
        case 0:
            item = twoArrays[0][indexPath.row]
            
        case 1:
            item = twoArrays[1][indexPath.row]

            
        default:
            item = twoArrays[2][indexPath.row]
            
            }
            
            
            } else {
                item = pArray[indexPath.row]
            }
            
        //Chect that items have been created by the itemStore
        if twoArrays.count == 3 {
            
        //Create font object with size set to 20 points
        
        
        var custCellFont: UIFont
        custCellFont = UIFont(name: "AppleSDGothicNeo-Medium", size:  20)!
        
        
        //Do not apply formatting to last row - no more items row
        if indexPath.section == 2  {
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = ""
            
        } else {
        
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        //Apply custom font to cell
            cell.textLabel?.font = custCellFont
            
            }
            
        } else {
            //Only one row to indicate that there are no items
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = ""
            
        }
        return cell
    }
    
    
    
    //Function to separate allItems array into 2 arrays one for items worth less the 50 dollars and the other for items worth more than fifty dollars. Use tuple to return the two arrays
    func createTwoArrays(_ parentArray: [Item]) -> [[Item]] {
        var greaterAndLess = [[Item]]()
        var lessThanFifty = [Item]()
        var moreThanFifty = [Item]()
        var noMoreItems = [Item]()
        
        for eachItem in parentArray {
            
            if eachItem.valueInDollars <     50 {
                lessThanFifty.append(eachItem)
            } else {
               moreThanFifty.append(eachItem)
            }
        }
        
        //Add artificial section to indicate that there are no more items at the bottom of the tableView
        //Add additional row to indicate that there are no more items
        let noMoreItemsItem = itemStore.createItem(requestRandom: false)
        
        //Set the name text for the item to "No more items"
        noMoreItemsItem.name = "No more items"
        
        //Add noMoreItemsItem to noMoreItems section
        noMoreItems.append(noMoreItemsItem)

        
        greaterAndLess.append(lessThanFifty)
        greaterAndLess.append(moreThanFifty)
        greaterAndLess.append(noMoreItems)


        
        return (greaterAndLess)
    }
}
