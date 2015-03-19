//
//  OGMCoursesViewController.m
//  NerdFeed
//
//  Created by Omri Meshulam on 3/19/15.
//  Copyright (c) 2015 Omri Meshulam. All rights reserved.
//

#import "OGMCoursesViewController.h"

@interface OGMCoursesViewController ()

@property (nonatomic) NSURLSession *session;

@end

@implementation OGMCoursesViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if(self){
        self.navigationItem.title = @"BNR Courses";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:nil
                                            delegateQueue:nil];
        [self fetchFeed];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
    cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)fetchFeed
{
    NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                         NSString *json = [[NSString alloc]initWithData:data
                                                                                               encoding:NSUTF8StringEncoding];
                                                         NSLog(@"%@",json);
                                                     }];
    [dataTask resume];
}


@end
