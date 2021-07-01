//
//  User.m
//  twitter
//
//  Created by Sarah Wen Gu on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    NSLog(@"%@", dictionary); 
    self = [super init];
    if (self){
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        
        self.followers =  [dictionary[@"followers_count"] intValue];
        
        self.following =  [dictionary[@"friends_count"] intValue];
        
        self.numTweets = [dictionary[@"statuses_count"] intValue];
    }
    return self;
}

@end
