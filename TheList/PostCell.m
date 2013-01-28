//
//  PostCell.m
//  TheList
//
//  Created by Jorge Izquierdo on 1/28/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (id)initWithIdentifier:(NSString *)reuseIdentifier longPressBlock:(LongPressBlock)b
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (b) block = [b copy];
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(50, 6, 320-50, 42)];
        title.numberOfLines = 2;
        title.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        title.textColor = [UIColor blackColor];
        
        url = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(title.frame), CGRectGetMaxY(title.frame)+5, CGRectGetWidth(title.frame), 10)];
        url.font = [UIFont italicSystemFontOfSize:9];
        url.textColor = [UIColor grayColor];
        
        points = [[UILabel alloc] initWithFrame:CGRectMake(4, 23, 42, 18)];
        points.font = [UIFont fontWithName:@"ProximaNova-Bold" size:18];
        points.textColor = title.textColor;
        points.textAlignment = NSTextAlignmentCenter;
        
        UILabel *p = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(points.frame), CGRectGetMaxY(points.frame)+1, CGRectGetWidth(points.frame), 12)];
        p.textAlignment = NSTextAlignmentCenter;
        p.textColor = [UIColor blackColor];
        p.font = [UIFont fontWithName:@"ProximaNova-Regular" size:10];
        p.text = @"points";
        
        title.backgroundColor = p.backgroundColor = url.backgroundColor = points.backgroundColor = [UIColor clearColor];
        
        UIView *r = [[UIView alloc] initWithFrame:CGRectMake(0, 65.5, 320, .5)];
        r.backgroundColor = [UIColor colorWithRed:.90 green:.29 blue:.28 alpha:1];
        [self addSubview:r];
        [self addSubview:points];
        [self addSubview:title];
        [self addSubview:url];
        [self addSubview:p];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lp)];
        [self addGestureRecognizer:lp];
        
        
    }
    return self;
}
-(void)lp{
    
    if (block) block(_post);
    
}
- (void)setPost:(Post *)p{
    
    if (p != _post){
        
        _post = p;
    }
    [self texts];
}
- (void)texts{
    
    points.text = [NSString stringWithFormat:@"%d", _post.score];
    title.text = _post.title;
    url.text = _post.url;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
