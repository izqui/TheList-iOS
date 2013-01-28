//
//  BrowserVC.h
//  TheList
//
//  Created by Jorge Izquierdo on 1/28/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@interface BrowserVC : UIViewController
{
    
    Post *post;
    UIWebView *wb;
}
- (id)initWithPost:(Post *)post;
@end
