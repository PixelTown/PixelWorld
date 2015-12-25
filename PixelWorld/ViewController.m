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
        [self.head setTitle:(NSString *)[self.dictionary objectForKey:@"head"] forState:UIControlStateNormal];
        //self.head.titleLabel.text = (NSString *)[self.dictionary objectForKey:@"head"];
        NSLog(@"head equip: %@", [self.dictionary objectForKey:@"head"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"armor"] != nil){
        [self.armor setTitle:(NSString *)[self.dictionary objectForKey:@"armor"] forState:UIControlStateNormal];
        //self.armor.titleLabel.text = (NSString *)[self.dictionary objectForKey:@"armor"];
        NSLog(@"armor equip: %@", [self.dictionary objectForKey:@"armor"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"boot"] != nil){
        [self.boot setTitle:(NSString *)[self.dictionary objectForKey:@"boot"] forState:UIControlStateNormal];
        //self.boot.titleLabel.text = (NSString *)[self.dictionary objectForKey:@"boot"];
        NSLog(@"boot equip: %@", [self.dictionary objectForKey:@"boot"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"left"] != nil){
        [self.left setTitle:(NSString *)[self.dictionary objectForKey:@"left"] forState:UIControlStateNormal];
        //self.left.titleLabel.text = (NSString *)[self.dictionary objectForKey:@"left"];
        NSLog(@"left hand: %@", [self.dictionary objectForKey:@"left"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"right"] != nil){
        [self.right setTitle:(NSString *)[self.dictionary objectForKey:@"right"] forState:UIControlStateNormal];
        //self.right.titleLabel.text = (NSString *)[self.dictionary objectForKey:@"right"];
        NSLog(@"right hand: %@", [self.dictionary objectForKey:@"right"]);
    }
    else{
        NSLog(@"fuck everything");
    }
    
    if([self.dictionary objectForKey:@"glove"] != nil){
        [self.glove setTitle:(NSString *)[self.dictionary objectForKey:@"glove"] forState:UIControlStateNormal];
        //self.glove.titleLabel.text = (NSString *)[self.dictionary objectForKey:@"glove"];
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

- (void)sendUnequip: (NSString *)itemName andField: (NSString *) field{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"loading the user data");
    
    //NSMutableDictionary *dictionary;
    
    NSDictionary *parameters = @{@"username": @"xiaofang", @"equipment": itemName, @"field": field};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/equip/unequip" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
        [self loadData:@"xiaofang"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (IBAction)unequipHead:(id)sender {
    NSString * unequipedItem = self.head.titleLabel.text;
    NSString * unequipedField = @"head";
    [self sendUnequip:unequipedItem andField:unequipedField];
    
}

- (IBAction)unequipLeft:(id)sender {
    NSString * unequipedItem = self.left.titleLabel.text;
    NSString * unequipedField = @"left";
    [self sendUnequip:unequipedItem andField:unequipedField];
}

- (IBAction)unequipRight:(id)sender {
    NSString * unequipedItem = self.right.titleLabel.text;
    NSString * unequipedField = @"right";
    [self sendUnequip:unequipedItem andField:unequipedField];
}

- (IBAction)unequipArmor:(id)sender {
    NSString * unequipedItem = self.armor.titleLabel.text;
    NSString * unequipedField = @"armor";
    [self sendUnequip:unequipedItem andField:unequipedField];
}

- (IBAction)unequipGlove:(id)sender {
    NSString * unequipedItem = self.glove.titleLabel.text;
    NSString * unequipedField = @"glove";
    [self sendUnequip:unequipedItem andField:unequipedField];
}

- (IBAction)unequipBoot:(id)sender {
    NSString * unequipedItem = self.boot.titleLabel.text;
    NSString * unequipedField = @"boot";
    [self sendUnequip:unequipedItem andField:unequipedField];
}

- (IBAction)refreshData:(id)sender {
    
    [self loadData:@"xiaofang"];
}
@end
