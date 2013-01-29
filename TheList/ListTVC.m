//
//  ListTVC.m
//  TheList
//
//  Created by Jorge Izquierdo on 1/28/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "ListTVC.h"
#import "AFNetworking.h"
#import "Post.h"
#import "ZYInstapaperActivity.h"
#import "ZYInstapaperActivityItem.h"
#import "ARChromeActivity.h"
#import "BrowserVC.h"

@interface ListTVC ()

@end

@implementation ListTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        pres = NO;
        longPress = ^(Post *p){
            
            if (!pres){
                pres = YES;
                //ZYInstapaperActivityItem *item = [[ZYInstapaperActivityItem alloc] initWithURL:[NSURL URLWithString:p.url]];
                //item.title = p.title;
                UIActivityViewController *activityCtr = [[UIActivityViewController alloc] initWithActivityItems:@[p.title, [NSURL URLWithString:p.url]] applicationActivities:@[[[ARChromeActivity alloc] init],[ZYInstapaperActivity instance]]];
                [self presentViewController:activityCtr animated:YES completion:^{
                    pres = NO;
                }];
            }
            
        };
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = [@"The List" uppercaseString];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIRefreshControl *rf = [[UIRefreshControl alloc] init];
    [rf addTarget:self action:@selector(get) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rf;
    [self get];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)get{
    
    NSURL *url = [NSURL URLWithString:@"http://thelist.io/posts.json"];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:url] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (JSON){
            
            NSMutableArray *_posts = [NSMutableArray array];
            
            for (NSDictionary *d in JSON){
                
                Post *p = [[Post alloc] initWithDict:d];
                [_posts addObject:p];
            }
            posts = _posts;
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
            
        }
        else {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self error:@"Request error. No response."];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        [self error:@"Request failed"];
    }];
    [op start];
    
}

-(void)error:(NSString *)error{
    
    [[[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) cell = [[PostCell alloc] initWithIdentifier:CellIdentifier longPressBlock:longPress firstCell:(indexPath.row == 0)];
    
    Post *p = posts[indexPath.row];
    [cell setPost:p];
    
    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 66.0f;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", posts[indexPath.row]);
    BrowserVC *b = [[BrowserVC alloc] initWithPost:posts[indexPath.row]];
    [self.navigationController pushViewController:b animated:YES];
}

@end
