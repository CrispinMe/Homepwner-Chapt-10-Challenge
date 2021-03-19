# Homepwner-Chapt-10-Challenge
Completed Challenges for Big Nerd Ranch Chapter 10 Challenges UITableView and UITableViewController
: the first array containin
Bronze Challenge - UITableView to display two distict sections: items less than $50.00 and items greater than $50.00 . Logic added to UIItemViewController to separate the items array supplied by the itemStore into two separate arrauys reflecting the price separation.
numberOfSections(in tableView: UITableView) -> Int method amended to return the number of sections to display in the table view.

Silver Challenge - Final row in the UITableView to display text: "No more items". Artificial third section created containing row with required text. Artificial item created with the the name property set to "No more items". Additional array, containing the "No more items" item, added to the array containing the two arrays containing the price separated items, to create a new section at the bottom of the UITableView 
The no more items row must appear, even if there are no items to display. Logic added to the viewDidLoad method of the UIItemsViewController, to check if items have been supplied by the ItemStore class; if not, an artificial item is created to display a row displaying that there are "No more items".

Gold Challenge - Row heights for all rows to be increased to 60 points and the font size to be increased to 20 points, except for the last row which is to remain at a height of 44 points and the font size to remain unchanged. Logic added to the tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat method to change the row height for all rows except the last row to 60 points. Logic added to the tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell method to change the font size for all rows except the last row to 20 points.
