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
    s.style = UIBarButtonItemStylePlain;
    s.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = s;
    
    self.view.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *sw = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(pop)];
    sw.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:sw];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
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
