//
//  OGMCoursesCell.h
//  NerdFeed
//
//  Created by Omri Meshulam on 3/19/15.
//  Copyright (c) 2015 Omri Meshulam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OGMCoursesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end