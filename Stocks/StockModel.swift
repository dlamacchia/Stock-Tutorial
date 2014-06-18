//
//  StockModel.swift
//  Stocks
//
//  Created by David LaMacchia on 6/17/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Foundation
import UIKit

class StockModel : NSObject {
    var symbols = String[]()

    init() {
        symbols = ["TWTR", "AAPL"]
    }

    class var sharedInstance : StockModel {
        struct Static {
            static let instance : StockModel = StockModel()
        }
        return Static.instance
    }

    func fetchInfoForSymbol(inSymbol: String, handler: (info: Dictionary<String, AnyObject>!, error: NSError!) -> ()) {
        let theURLString = "http://dev.markitondemand.com/Api/v2/Quote/json?symbol=" + inSymbol
        let theURL = NSURL.URLWithString(theURLString)
        var theRequest = NSURLRequest(URL: theURL)
        var theTask = NSURLSession.sharedSession().dataTaskWithRequest(theRequest, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) in
            var responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            let theJSON: Dictionary<String, AnyObject> = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as Dictionary<String, AnyObject>
            handler(info: theJSON, error: nil)
        })

        theTask.resume()
    }
}
