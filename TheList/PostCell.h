//
//  PostCell.h
//  TheList
//
//  Created by Jorge Izquierdo on 1/28/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
typedef void (^LongPressBlock) ();

@interface PostCell : UITableViewCell
{
    
    Post *_post;
    LongPressBlock block;
    
    UILabel *title, *url, *points;
}
- (id)initWithIdentifier:(NSString *)reuseIdentifier longPressBlock:(LongPressBlock)b firstCell:(BOOL)f;
@property (nonatomic, strong) Post *post;
@end
