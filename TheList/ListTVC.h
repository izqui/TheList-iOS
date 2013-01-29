//
//  ListTVC.h
//  TheList
//
//  Created by Jorge Izquierdo on 1/28/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostCell.h"

@interface ListTVC : UITableViewController
{
    
    NSArray *posts;
    LongPressBlock longPress;
    BOOL pres;
    int page;
    UILabel *load;
}
@end
