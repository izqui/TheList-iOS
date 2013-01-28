//
//  Post.h
//  TheList
//
//  Created by Jorge Izquierdo on 1/28/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property (nonatomic, strong) NSString *title, *url, *_id, *uid; //YEAH, I prefer having a string
@property (nonatomic) NSInteger score;
//@property (nonatomic, strong) NSDate *date;
-(id)initWithDict:(NSDictionary *)d;
@end
