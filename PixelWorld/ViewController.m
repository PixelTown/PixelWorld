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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"doing shit now");
    
    NSDictionary *parameters = @{@"username": Username};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/user/getuser" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
        NSError * error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"dic count :%lu", (unsigned long)dictionary.count);
        
        for(id key in dictionary) {
            NSLog(@"key :%@  value :%@", key, [dictionary objectForKey:key]);
        }
        
        NSLog(@"yooo####################################yooo");
        
        if([dictionary objectForKey:@"username"] != nil){
            self.Username.text = (NSString *)[dictionary objectForKey:@"username"];
            NSLog(@"username is: %@", [dictionary objectForKey:@"username"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"lv"] != nil){
            
            NSString * haha = [NSString stringWithFormat: @"%@", (NSString *)[dictionary objectForKey:@"lv"]];
            self.Level.text = haha;
            NSLog(@"level of hero: %@", [dictionary objectForKey:@"lv"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"atk"] != nil){
            self.Atk.text = [NSString stringWithFormat: @"%@", (NSString *)[dictionary objectForKey:@"atk"]];
            NSLog(@"attack damage: %@", [dictionary objectForKey:@"atk"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"def"] != nil){
            self.Def.text = [NSString stringWithFormat: @"%@", (NSString *)[dictionary objectForKey:@"def"]];
            NSLog(@"defense: %@", [dictionary objectForKey:@"def"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"hp"] != nil){
            self.HP.text = [NSString stringWithFormat: @"%@", (NSString *)[dictionary objectForKey:@"hp"]];
            NSLog(@"health point: %@", [dictionary objectForKey:@"hp"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"head"] != nil){
            self.head.text = (NSString *)[dictionary objectForKey:@"head"];
            NSLog(@"head equip: %@", [dictionary objectForKey:@"head"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"armor"] != nil){
            self.armor.text = (NSString *)[dictionary objectForKey:@"armor"];
            NSLog(@"armor equip: %@", [dictionary objectForKey:@"armor"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"boot"] != nil){
            self.boot.text = (NSString *)[dictionary objectForKey:@"boot"];
            NSLog(@"boot equip: %@", [dictionary objectForKey:@"boot"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"left"] != nil){
            self.left.text = (NSString *)[dictionary objectForKey:@"left"];
            NSLog(@"left hand: %@", [dictionary objectForKey:@"left"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"right"] != nil){
            self.right.text = (NSString *)[dictionary objectForKey:@"right"];
            NSLog(@"right hand: %@", [dictionary objectForKey:@"right"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        if([dictionary objectForKey:@"glove"] != nil){
            self.glove.text = (NSString *)[dictionary objectForKey:@"glove"];
            NSLog(@"glove equip: %@", [dictionary objectForKey:@"glove"]);
        }
        else{
            NSLog(@"fuck everything");
        }
        
        NSLog(@"done");
        
        if([dictionary objectForKey:@"floor"] != nil){
            int f = (int)[dictionary objectForKey:@"glove"];
            [[NSUserDefaults standardUserDefaults] setInteger:f forKey:@"floorNumber"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
         
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];


}



- (IBAction)refreshData:(id)sender {
    
    [self loadData:@"xiaofang"];
}
@end
