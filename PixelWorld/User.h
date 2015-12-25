//
//  User.h
//  PixelWorld
//
//  Created by Yifang Zhang on 12/23/15.
//  Copyright © 2015 Yifang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface User : NSObject


@property NSMutableDictionary * userStatusDictionary;
@property NSString * xiaofang;

+(User *)sharedInstance;

@end
