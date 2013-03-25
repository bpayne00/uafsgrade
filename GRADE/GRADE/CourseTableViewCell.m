//
//  CourseTableViewCell.m
//  iPadLoginTestNavController
//
//  Created by Blake Payne on 2/25/13.
//  Copyright (c) 2013 Blake Payne. All rights reserved.
//

#import "CourseTableViewCell.h"
#import "Course.h"

@implementation CourseTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UITableViewCell *)setCourse:(Course *)c{
    self.textLabel.text = c.name;
    self.detailTextLabel.text = c.description;
    return self;
}

@end
