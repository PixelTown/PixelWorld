//
//  ViewController.h
//  PixelWorld
//
//  Created by Yifang Zhang on 12/13/15.
//  Copyright © 2015 Yifang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *Username;
@property (strong, nonatomic) IBOutlet UILabel *Level;
@property (strong, nonatomic) IBOutlet UILabel *Atk;
@property (strong, nonatomic) IBOutlet UILabel *Def;
@property (strong, nonatomic) IBOutlet UILabel *HP;
@property (strong, nonatomic) IBOutlet UILabel *head;
@property (strong, nonatomic) IBOutlet UILabel *armor;
@property (strong, nonatomic) IBOutlet UILabel *left;
@property (strong, nonatomic) IBOutlet UILabel *right;
@property (strong, nonatomic) IBOutlet UILabel *glove;
@property (strong, nonatomic) IBOutlet UILabel *boot;

- (IBAction)refreshData:(id)sender;

@end

