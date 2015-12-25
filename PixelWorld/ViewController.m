//
//  ViewController.m
//  PixelWorld
//
//  Created by Yifang Zhang on 12/13/15.
//  Copyright © 2015 Yifang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData: (NSString *) Username {
    
    //self.dictionary =
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"loading the user data");
    
    //NSMutableDictionary *dictionary;
    
    NSDictionary *parameters = @{@"username": Username};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/user/getuser" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
        NSError * error;
        self.dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        //NSLog(@"dic count :%lu", (unsigned long)self.userStatusDictionary.count);
        
        /*for(id key in self.userStatusDictionary) {
         NSLog(@"key :%@  value :%@", key, [self.userStatusDictionary objectForKey:key]);
         }*/
        
        NSLog(@"yooo####################################yooo");
        
        [self dataToInterface];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];



    
}


- (void) dataToInterface{

    if([self.dictionary objectForKey:@"username"] != nil){
        self.Username.text = (NSString *)[self.dictionary objectForKey:@"username"];
        NSLog(@"username is: %@", [self.dictionary objectForKey:@"username"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"lv"] != nil){
        
        NSString * haha = [NSString stringWithFormat: @"%@", (NSString *)[self.dictionary objectForKey:@"lv"]];
        self.Level.text = haha;
        NSLog(@"level of hero: %@", [self.dictionary objectForKey:@"lv"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"atk"] != nil){
        self.Atk.text = [NSString stringWithFormat: @"%@", (NSString *)[self.dictionary objectForKey:@"atk"]];
        NSLog(@"attack damage: %@", [self.dictionary objectForKey:@"atk"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"def"] != nil){
        self.Def.text = [NSString stringWithFormat: @"%@", (NSString *)[self.dictionary objectForKey:@"def"]];
        NSLog(@"defense: %@", [self.dictionary objectForKey:@"def"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"hp"] != nil){
        self.HP.text = [NSString stringWithFormat: @"%@", (NSString *)[self.dictionary objectForKey:@"hp"]];
        NSLog(@"health point: %@", [self.dictionary objectForKey:@"hp"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"head"] != nil){
        self.head.text = (NSString *)[self.dictionary objectForKey:@"head"];
        NSLog(@"head equip: %@", [self.dictionary objectForKey:@"head"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"armor"] != nil){
        self.armor.text = (NSString *)[self.dictionary objectForKey:@"armor"];
        NSLog(@"armor equip: %@", [self.dictionary objectForKey:@"armor"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"boot"] != nil){
        self.boot.text = (NSString *)[self.dictionary objectForKey:@"boot"];
        NSLog(@"boot equip: %@", [self.dictionary objectForKey:@"boot"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"left"] != nil){
        self.left.text = (NSString *)[self.dictionary objectForKey:@"left"];
        NSLog(@"left hand: %@", [self.dictionary objectForKey:@"left"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"right"] != nil){
        self.right.text = (NSString *)[self.dictionary objectForKey:@"right"];
        NSLog(@"right hand: %@", [self.dictionary objectForKey:@"right"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"glove"] != nil){
        self.glove.text = (NSString *)[self.dictionary objectForKey:@"glove"];
        NSLog(@"glove equip: %@", [self.dictionary objectForKey:@"glove"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    NSLog(@"done");
    
    if([self.dictionary objectForKey:@"floor"] != nil){
        NSString * f = [NSString stringWithFormat:@"%@", [self.dictionary objectForKey:@"floor"]];
        NSLog(@"%@", f);
        [[NSUserDefaults standardUserDefaults] setObject:f forKey:@"floorNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    
}

- (IBAction)refreshData:(id)sender {
    
    [self loadData:@"xiaofang"];
}
@end
