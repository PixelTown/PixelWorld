//
//  monsterViewController.h
//  PixelWorld
//
//  Created by Yifang Zhang on 12/21/15.
//  Copyright © 2015 Yifang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface monsterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *monsterName;
@property (strong, nonatomic) IBOutlet UILabel *Atk;
@property (strong, nonatomic) IBOutlet UILabel *Def;
@property (strong, nonatomic) IBOutlet UILabel *HP;
@property int floorNum;

- (IBAction)ExitDungeon:(id)sender;
- (IBAction)NextFloor:(id)sender;
- (IBAction)PreviousFloor:(id)sender;
- (IBAction)FightMonster:(id)sender;


@end
