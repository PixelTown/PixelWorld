//
//  inventoryTableViewController.h
//  PixelWorld
//
//  Created by Yifang Zhang on 12/22/15.
//  Copyright © 2015 Yifang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface inventoryTableViewController : UITableViewController

@property NSMutableArray * inventoryData;
@property NSUInteger * selectedRow;
@property NSDictionary * selectedItem;

@end
