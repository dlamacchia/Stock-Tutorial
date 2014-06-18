//
//  SymbolViewController.swift
//  Stocks
//
//  Created by David LaMacchia on 6/14/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Foundation
import UIKit

class SymbolViewController: UIViewController {
    var stockInfo = Dictionary<String, AnyObject>()
    var symbol = String()

    @IBOutlet var priceLabel = UILabel()
    @IBOutlet var openClosePriceLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        var title = symbol
        var handler = {
            (#info: Dictionary<String, AnyObject>!, #error: NSError!) -> () in
            self.stockInfo = info

            dispatch_async(dispatch_get_main_queue(), {
                var theFormatter = NSNumberFormatter()
                theFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
                if self.stockInfo["LastPrice"] {
                    if let lastPrice = self.stockInfo["LastPrice"] as Double! {
                        self.priceLabel.text = theFormatter.stringFromNumber(lastPrice.bridgeToObjectiveC().doubleValue)
                    }
                }
                if self.stockInfo["Open"] {
                    if let openPrice = self.stockInfo["Open"] as Double! {
                        self.openClosePriceLabel.text = "Open: " + theFormatter.stringFromNumber(openPrice.bridgeToObjectiveC().doubleValue)
                    }
                }
            })
        }

        StockModel.sharedInstance.fetchInfoForSymbol(title, handler: handler)
        return
    }
}
