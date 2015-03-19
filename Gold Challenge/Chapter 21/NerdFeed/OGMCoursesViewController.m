//
//  OGMCoursesViewController.m
//  NerdFeed
//
//  Created by Omri Meshulam on 3/19/15.
//  Copyright (c) 2015 Omri Meshulam. All rights reserved.
//

#import "OGMCoursesViewController.h"
#import "OGMWebViewController.h"
#import "OGMCoursesCell.h"


@interface OGMCoursesViewController () <NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;

@end

@implementation OGMCoursesViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if(self){
        self.navigationItem.title = @"BNR Courses";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:self
                                            delegateQueue:nil];
        [self fetchFeed];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Load the nib file
    UINib *nib=[UINib nibWithNibName:@"OGMCoursesCell" bundle:nil];
    
    //Register nib
    [self.tableView registerNib:nib forCellReuseIdentifier:@"OGMCoursesCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
    cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OGMCoursesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OGMCoursesCell"
                                                            forIndexPath:indexPath];
    NSDictionary *course =  self.courses[indexPath.row];
    NSDictionary *details=[course[@"upcoming"] objectAtIndex:0];
    
    cell.titleLabel.text=course[@"title"];
    if (details) {
        cell.dateLabel.text = [NSString stringWithFormat:@"Start Date: %@", details[@"start_date"]];
        cell.instructorLabel.text=details[@"instructors"];
    }else{
        cell.dateLabel.text= @"TBA";
        cell.instructorLabel.text=@"TBA";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course = self.courses[indexPath.row];
    NSURL *URL = [NSURL URLWithString:course[@"url"]];
    
    self.webViewController.title = course[@"title"];
    self.webViewController.URL = URL;
    [self.navigationController pushViewController:self.webViewController
                                         animated:YES];
}

- (void)fetchFeed
{
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                         NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                     options:0
                                                                                                                       error:nil];
                                                         //NSLog(@"%@",jsonObject);
                                                         self.courses = jsonObject[@"courses"];
                                                         NSLog(@"%@", self.courses);
                                                         
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             [self.tableView reloadData];
                                                         });
                                          
                                                     }
                                      ];
                                      
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"BigNerdRanch"
                                                       password:@"AchieveNerdvana"
                                                    persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

@end
