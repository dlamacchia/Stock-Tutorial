//
//  SymbolsTableViewController.swift
//  Stocks
//
//  Created by David LaMacchia on 6/11/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Foundation
import UIKit

class SymbolsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var symbols = String[]()

    override func viewDidLoad() {
        super.viewDidLoad()

        symbols = StockModel.sharedInstance.symbols as String[]
    }

    override func numberOfSectionsInTableView(tableView: UITableView!)->Int {
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return symbols.count
    }

    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell : UITableViewCell! = tableView!.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel.text = symbols[indexPath!.row]

        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let cell : UITableViewCell! = sender as UITableViewCell
        let indexPath : NSIndexPath = self.tableView.indexPathForCell(cell)
        let symbol : NSString = symbols[indexPath.row]

        let theViewController : SymbolViewController = segue.destinationViewController as SymbolViewController
        theViewController.symbol = symbol

    }
}
