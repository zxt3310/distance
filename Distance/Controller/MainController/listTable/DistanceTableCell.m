//
//  DistanceTableCell.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "DistanceTableCell.h"

@implementation DistanceTableCell
{
    UILabel *_nameLb;
    UILabel *_distanceLb;
    UILabel *_tsLb;
}
@synthesize distance = _distance;

- (instancetype)initWithFlex:(NSString *)flexName reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithFlex:flexName reuseIdentifier:reuseIdentifier];
    if (self) {
        [self enableFlexLayout:YES];
    }
    return self;
}

- (void)setDistance:(DistanceModel *)distance{
    _distance = distance;
    
    _nameLb.text = Kstr(distance.nick_name);
    _distanceLb.text = [NSString stringWithFormat:@"%@ 米",Kstr(stringOfFloat(distance.distance))];
    _tsLb.text = Kstr(distance.updated_at);
}

@end
