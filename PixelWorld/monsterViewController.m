//
//  monsterViewController.m
//  PixelWorld
//
//  Created by Yifang Zhang on 12/21/15.
//  Copyright © 2015 Yifang. All rights reserved.
//

#import "monsterViewController.h"
#import "AFNetworking.h"

@interface monsterViewController ()

@end

@implementation monsterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"floorNumber"] != nil) {
        self.floorNum =  [[NSUserDefaults standardUserDefaults] integerForKey:@"floorNumber"];
    }
    else{
        self.floorNum = 0;
    }
    [self buttomCheck];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    if ((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"floorNumber"] != nil) {
        self.floorNum =  [(NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"floorNumber"] intValue];
        NSLog(@"loaded floor is %d", self.floorNum);
    }
    else{
        self.floorNum = 0;
    }
    [self buttomCheck];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ExitDungeon:(id)sender {
    
    NSLog(@"dungeon reset");
    self.floorNum = 0;
    self.FloorNumber.text = [NSString stringWithFormat:@"Floor %d", self.floorNum];
    [self requestMonster];
    NSLog([NSString stringWithFormat:@"floor is: %d", self.floorNum]);
    [self buttomCheck];
    
}

- (IBAction)NextFloor:(id)sender {
    
    NSLog(@"go to next floor");
    self.floorNum = self.floorNum + 1;
    self.FloorNumber.text = [NSString stringWithFormat:@"Floor %d", self.floorNum];
    [self requestMonster];
    NSLog([NSString stringWithFormat:@"floor is: %d", self.floorNum]);
    [self buttomCheck];
}

- (IBAction)PreviousFloor:(id)sender {
    
    
    
    NSLog(@"go to previous floor");
    self.floorNum = self.floorNum - 1;
    self.FloorNumber.text = [NSString stringWithFormat:@"Floor %d", self.floorNum];
    [self requestMonster];
    NSLog([NSString stringWithFormat:@"floor is: %d", self.floorNum]);
    [self buttomCheck];
}

- (IBAction)FightMonster:(id)sender {
    
    NSLog(@"fight this shit");
    [self requestFighting];
    NSLog([NSString stringWithFormat:@"floor is: %d", self.floorNum]);
    [self buttomCheck];
    
}

- (void)requestMonster{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"going to fight");
    
    NSString * floor = [NSString stringWithFormat:@"%d", self.floorNum];
    
    NSDictionary *parameters = @{@"username": @"xiaofang", @"floor": floor};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/battle/monster" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
        
        NSError * error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"dic count :%lu", (unsigned long)dictionary.count);
        
        
        
        // 5 stupid shit here
        if([dictionary objectForKey:@"name"] != nil){
            
            NSString * haha = [NSString stringWithFormat: @"%@", (NSString *)[dictionary objectForKey:@"name"]];
            self.monsterName.text = haha;
            NSLog(@"monster name: %@", [dictionary objectForKey:@"name"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"atk"] != nil){
            
            NSString * haha = [NSString stringWithFormat: @"%@", (NSString *)[dictionary objectForKey:@"atk"]];
            self.Atk.text = haha;
            NSLog(@"monster attack: %@", [dictionary objectForKey:@"atk"]);
        }
        else{
            NSLog(@"fuck everything");
        }

        if([dictionary objectForKey:@"def"] != nil){
            
            NSString * haha = [NSString stringWithFormat: @"%@", (NSString *)[dictionary objectForKey:@"def"]];
            self.Def.text = haha;
            NSLog(@"monster defense: %@", [dictionary objectForKey:@"def"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"hp"] != nil){
            
            NSString * haha = [NSString stringWithFormat: @"%@", (NSString *)[dictionary objectForKey:@"hp"]];
            self.HP.text = haha;
            NSLog(@"monster HP: %@", [dictionary objectForKey:@"hp"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"description"] != nil){
            
            NSString * haha = [NSString stringWithFormat: @"%@", (NSString *)[dictionary objectForKey:@"description"]];
            self.monsterDescription.text = haha;
            NSLog(@"monster description: %@", [dictionary objectForKey:@"description"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        // end of 5 stupid shit
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];


}

- (void)requestFighting{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"going to fight");
    
    NSString * floor = [NSString stringWithFormat:@"%d", self.floorNum];
    
    NSDictionary *parameters = @{@"username": @"xiaofang", @"floor": floor};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/battle/fight" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)buttomCheck{

    if (self.floorNum <= 0) {
        self.exitDungeonBtn.enabled = NO;
        self.previousFloorBtn.enabled = NO;
        self.fightBtn.enabled = NO;
        self.nextFloorBtn.enabled = YES;
    }
    
    else if (self.floorNum >=2) {
        self.exitDungeonBtn.enabled = YES;
        self.previousFloorBtn.enabled = YES;
        self.fightBtn.enabled = YES;
        self.nextFloorBtn.enabled = NO;
    }
    
    else{
        self.exitDungeonBtn.enabled = YES;
        self.previousFloorBtn.enabled = YES;
        self.fightBtn.enabled = YES;
        self.nextFloorBtn.enabled = YES;
    }
    
}

@end
