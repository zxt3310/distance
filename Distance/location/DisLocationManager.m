//
//  DisLocationManager.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "DisLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "DisLocationUpdateReq.h"

@interface DisLocationManager ()<CLLocationManagerDelegate>

@property CLLocationManager *manager;

@property NSDate *upDate;

@end

@implementation DisLocationManager
{
    NSTimer *timer;
}

+ (instancetype)sharedManager{
    static DisLocationManager *singleManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleManager = [[self alloc] init];
        singleManager.manager = [[CLLocationManager alloc] init];
        singleManager.manager.activityType = CLActivityTypeFitness;
        singleManager.manager.desiredAccuracy = kCLLocationAccuracyBest;
        singleManager.manager.distanceFilter = kCLDistanceFilterNone;
    });
    return singleManager;
}

- (void)beginUpdateLocation{
    self.manager.delegate = self;
    [self.manager requestWhenInUseAuthorization];
    timer = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(startLocation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer setFireDate:[NSDate date]];
}

- (void)stopUpdateLocation{
    if (timer.isValid) {
        [timer setFireDate:[NSDate distantFuture]];
        [timer invalidate];
    }
}

- (void)startLocation{
    [self.manager requestLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (![DISUserInfo sharedInfo].userid) {
        NSLog(@"尚未登录 或 已开启定位");
        return;
    }
    
    if (locations && locations.count>0) {
        for (CLLocation *location in locations) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[DISUserInfo sharedInfo].userid,@"userid",
                                                                            stringOfDouble(location.coordinate.latitude),@"lat",
                                 stringOfDouble(location.coordinate.longitude),@"lng",nil];
            
            DisLocationUpdateReq *req = [[DisLocationUpdateReq alloc] initWithParam:dic];
            [req startRequest];
            self.upDate = [NSDate date];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

@end
