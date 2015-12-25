//
//  User.m
//  PixelWorld
//
//  Created by Yifang Zhang on 12/23/15.
//  Copyright © 2015 Yifang. All rights reserved.
//

#import "User.h"

@interface User ()
-(id)initialize;
@end


@implementation User



+(User *)sharedInstance
{
    static User *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(void) {
        sharedSingleton = [[self alloc] initialize];
    });
    return sharedSingleton;
}
-(id)initialize
{
    if(self == [super init] )
    {
        //initial something here
        self.xiaofang = @"xiaofang";
        [self gettingUserStatusDictionary:self.xiaofang];
    } 
    return self; 
}

- (void) gettingUserStatusDictionary: (NSString *) username{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"loading the user data");
    
    //NSMutableDictionary *dictionary;
    
    NSDictionary *parameters = @{@"username": username};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/user/getuser" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
        NSError * error;
        self.userStatusDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        //NSLog(@"dic count :%lu", (unsigned long)self.userStatusDictionary.count);
        
        /*for(id key in self.userStatusDictionary) {
            NSLog(@"key :%@  value :%@", key, [self.userStatusDictionary objectForKey:key]);
        }*/
        
        NSLog(@"yooo####################################yooo");
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

@end
