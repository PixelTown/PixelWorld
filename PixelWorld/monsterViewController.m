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
        self.floorNum = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"floorNumber"];
    }
    else{
        self.floorNum = 0;
    }
    
    
    // Do any additional setup after loading the view.
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
    [self requestMonster];
    NSLog([NSString stringWithFormat:@"floor is: %d", self.floorNum]);
    
}

- (IBAction)NextFloor:(id)sender {
    
    NSLog(@"go to next floor");
    self.floorNum = self.floorNum + 1;
    [self requestMonster];
    NSLog([NSString stringWithFormat:@"floor is: %d", self.floorNum]);
}

- (IBAction)PreviousFloor:(id)sender {
    
    NSLog(@"go to previous floor");
    self.floorNum = self.floorNum - 1;
    [self requestMonster];
    NSLog([NSString stringWithFormat:@"floor is: %d", self.floorNum]);
}

- (IBAction)FightMonster:(id)sender {
    
    NSLog(@"fight this shit");
    [self requestFighting];
    NSLog([NSString stringWithFormat:@"floor is: %d", self.floorNum]);
    
}

- (void)requestMonster{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"doing shit now");
    
    NSDictionary *parameters = @{@"username": @"xiaofang"};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/user/getuser" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];


}

- (void)requestFighting{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"doing shit now");
    
    NSDictionary *parameters = @{@"username": @"xiaofang"};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/user/getuser" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

@end
