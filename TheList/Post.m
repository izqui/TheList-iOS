//
//  Post.m
//  TheList
//
//  Created by Jorge Izquierdo on 1/28/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "Post.h"

@implementation Post
-(id)initWithDict:(NSDictionary *)d{
    
    self = [super init];
    if (self){
        
        self.title = d[@"title"];
        self.url = d[@"url"];
        self._id = d[@"id"];
        self.uid = d[@"user_id"];
        self.score = [d[@"score"] integerValue];
        //TODO: PARSE DATE
        
        
    }
    return self;
}
@end
