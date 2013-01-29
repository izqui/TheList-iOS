//
//  BrowserVC.m
//  TheList
//
//  Created by Jorge Izquierdo on 1/28/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "BrowserVC.h"
#import "ARChromeActivity.h"
#import "ZYInstapaperActivity.h"
@implementation BrowserVC

- (id)initWithPost:(Post *)p
{
    self = [super init];
    if (self) {
        
        
        
    
        wb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-64)];
        wb.scalesPageToFit = YES;
        wb.backgroundColor = [UIColor blackColor];
        [self.view addSubview:wb];
        [wb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:p.url]]];
        
        self.title = p.title;
       
        post = p;
    }
    
    return self;
}

- (void)viewDidLoad
{
   
    
    UIBarButtonItem *s = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = s;
    self.navigationItem.backBarButtonItem.title = @"Back";
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)share{
    
    UIActivityViewController *activityCtr = [[UIActivityViewController alloc] initWithActivityItems:@[post.title, [NSURL URLWithString:post.url]] applicationActivities:@[[[ARChromeActivity alloc] init],[ZYInstapaperActivity instance]]];
    [self presentViewController:activityCtr animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
