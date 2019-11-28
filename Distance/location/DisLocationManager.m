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
#import "BgDispatchTimer.h"
#import "BGTaskManager.h"

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
        singleManager.manager.activityType = CLActivityTypeOther;
    });
    return singleManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)beginUpdateLocation{
    self.manager.delegate = self;
    [self.manager requestAlwaysAuthorization];
    [self startLocation];
}

- (void)stopUpdateLocation{
    if (timer.isValid) {
        [timer setFireDate:[NSDate distantFuture]];
        [timer invalidate];
    }
}

- (void)requestLocation{
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.distanceFilter = 0;
    [self.manager requestLocation];
}

- (void)startLocation{
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
        [self.manager startMonitoringSignificantLocationChanges];
        //[self.manager startUpdatingLocation];
    }
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
    
    for (CLLocation *loc in locations) {
        double lot = loc.coordinate.longitude;
        double lat = loc.coordinate.latitude;
        NSString *str = [NSString stringWithFormat:@"{\"lot\":%f,\"lat\":%f}",lot,lat];
        [DisLog WriteLocate:str];
        
        [DisLog Write:[NSString stringWithFormat:@"记录位置信息%@",str] To:LOG_User];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

- (void)applicationEnterBackground{
    
    [DisLog Write:@"启动后台任务" To:LOG_User];
    
    BGTaskManager *manager = [BGTaskManager defaultManager];
    
    [manager beginNewBackgroundTask];
    
//    [BgDispatchTimer cancelAllTimer];
    
    //[BgDispatchTimer scheduleDispatchTimerWithName:@"upload" timeInterval:120 queue:nil repeats:YES action:^{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *strPath = [documentsPath stringByAppendingPathComponent:LOG_Loc];
        BOOL exist = [[[NSFileManager alloc] init] fileExistsAtPath:strPath];
        if (exist) {
            NSString *pathStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
            pathStr = [pathStr stringByAppendingString:@"]"];
            pathStr = [@"[" stringByAppendingString:pathStr];
            NSArray *ary = [NSArray yy_modelArrayWithClass:[MovePoint class] json:[NSJSONSerialization JSONObjectWithData:[pathStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil]];
            MovePoint *loc = [ary lastObject];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[DISUserInfo sharedInfo].userid,@"userid",
                                 stringOfDouble(loc.lat),@"lat",
                                 stringOfDouble(loc.lot),@"lng",nil];
            
            DisLocationUpdateReq *req = [[DisLocationUpdateReq alloc] initWithParam:dic];
            [req startRequest];
            
            
        }
    });
    
    
    //}];
    
//    BGTaskManager *manager = [BGTaskManager defaultManager];
//
//    [manager beginNewBackgroundTask];
}

- (void)uploadLocation{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPath = [documentsPath stringByAppendingPathComponent:LOG_Loc];
    BOOL exist = [[[NSFileManager alloc] init] fileExistsAtPath:strPath];
    if (exist) {
        NSString *pathStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
        pathStr = [pathStr stringByAppendingString:@"]"];
        pathStr = [@"[" stringByAppendingString:pathStr];
        NSArray *ary = [NSArray yy_modelArrayWithClass:[MovePoint class] json:[NSJSONSerialization JSONObjectWithData:[pathStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil]];
        MovePoint *loc = [ary lastObject];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[DISUserInfo sharedInfo].userid,@"userid",
                             stringOfDouble(loc.lat),@"lat",
                             stringOfDouble(loc.lot),@"lng",nil];
        
        DisLocationUpdateReq *req = [[DisLocationUpdateReq alloc] initWithParam:dic];
        [req startRequest];
    }
}




@end
