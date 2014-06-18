//
//  SymbolViewController.m
//  Stocks
//
//  Created by Jonathan Wight on 6/9/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

#import "SymbolViewController.h"

#import "StockModel.h"

@interface SymbolViewController ()
@property (readwrite, nonatomic, copy) NSDictionary *stockInfo;
@property (readwrite, nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (readwrite, nonatomic, weak) IBOutlet UILabel *openClosePriceLabel;
@end

@implementation SymbolViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.symbol;


    __weak typeof(self) weak_self = self;
    [[StockModel sharedInstance] fetchInfoForSymbol:self.symbol handler:^(NSDictionary *info, NSError *error) {
        __strong typeof(self) strong_self = weak_self;
        if (strong_self == NULL) {
            NSLog(@"Received symbol info after view controller has gone away!");
            return;
        }
        // Error checking is for the weak.
        dispatch_async(dispatch_get_main_queue(), ^{
            strong_self.stockInfo = info;
            NSNumberFormatter *theFormatter = [[NSNumberFormatter alloc] init];
            theFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
            strong_self.priceLabel.text = [NSString stringWithFormat:@"%@", [theFormatter stringFromNumber:strong_self.stockInfo[@"LastPrice"]]];
            strong_self.openClosePriceLabel.text = [NSString stringWithFormat:@"Open: %@", [theFormatter stringFromNumber:strong_self.stockInfo[@"Open"]]];
        });

    }];
}

@end
