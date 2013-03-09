//
//  APTableViewController.m
//  InstagramFeed
//
//  Created by mac on 02.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APTableViewController.h"
#import "APInstagramFeed.h"
#import "APUserMedia.h"
#import "APCustomTableViewCell.h"
#import "APDetailedViewController.h"

@interface APTableViewController ()

@end

@implementation APTableViewController

@synthesize feed = _feed;
@synthesize accessToken = _accessToken;
@synthesize nextURL = _nextURL;
@synthesize upButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.navigationItem.hidesBackButton = YES;
        self.tableView.rowHeight = 320;
        self.navigationItem.title = @"Feed";
        isLoadingNewPage = NO;
    }
    return self;
}

- (id)initWithAccessToken:(NSString*)newAccessToken andFeed:(NSArray *)initFeed andNextURL:(NSString *)nextPageURL{
    self = [super init];
    if (self) {
        self.accessToken = [NSString stringWithString:newAccessToken];
        self.nextURL = nextPageURL;
        self.feed = [[[NSArray alloc]initWithArray:initFeed]autorelease];
    }
    return self;
}

- (void)loadView{
    [super loadView];
    upButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Up"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(scrollToTheTop)];
}

- (void)scrollToTheTop{
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

//request new data for tableView
- (void)requestFeed{
    
    [APInstagramFeed getFeedMediaWithAccessToken:self.accessToken andPath:self.nextURL block:^(NSArray *records, NSString *nextPage) {
        
        self.nextURL = nextPage;
        if(isLoadingNewPage){
            NSArray* newFeed = [self.feed arrayByAddingObjectsFromArray:records];
            self.feed = newFeed;
            isLoadingNewPage = NO;
            //NSLog(@"scroll");
        }
        else {
            self.feed = records;
            //NSLog(@"refresh");
        }
        
        [self.tableView reloadData];
    }];
    
    if(isLoading)[self stopLoading];
    
}

//pull to refresh override
- (void)refresh {
    self.nextURL = @"";
    [self performSelector:@selector(requestFeed) withObject:nil afterDelay:1.0];
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
    return [self.feed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    APCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[APCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    [cell setImageURL:[[self.feed objectAtIndex:indexPath.row]standardUrl]];
    
    return cell;
}

//detect the bottom and add new data
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
    if(scrollView.contentOffset.y >= (scrollView.contentSize.height - 5*scrollView.bounds.size.height) && !isLoadingNewPage){
        isLoadingNewPage = YES;

        //load the next page
        [self requestFeed];
    }
    
    //bar button appearance
    if(scrollView.contentOffset.y >= scrollView.bounds.size.height){
        [self.navigationItem setRightBarButtonItem:upButton animated:YES];
    }
    else{
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    APDetailedViewController* imageViewController = [[APDetailedViewController alloc]initWithData:[self.feed objectAtIndex:indexPath.row]andAccessToken:self.accessToken];
    [self.navigationController pushViewController:imageViewController animated:YES];
    [imageViewController release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc{
    [_nextURL release];
    [_accessToken release];
    [_feed release];
    [upButton release];
    [super dealloc];
}

@end
