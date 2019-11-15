//
//  PRMovePathViewController.m
//  pathRecordDiary
//
//  Created by 张信涛 on 2019/10/27.
//  Copyright © 2019年 www.zongjila.com. All rights reserved.
//

#import "PRMovePathViewController.h"
#import <MapKit/MapKit.h>

@interface PRMovePathViewController ()<MKMapViewDelegate>
@property MKPolyline *routeLine;
@property MKPolylineRenderer *routeLineView;
@property NSMutableArray *lines;
@end

@implementation PRMovePathViewController
{
    MKMapView *mapView;
    NSArray *pointAry;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.delegate = self;
    mapView.rotateEnabled = NO;
    [self.view addSubview:mapView];
    
    self.lines = [NSMutableArray array];
    
    [self requestPoints];
}


- (void)drawLineWithLocationArray:(NSArray *)locationArray
{
    NSUInteger pointCount = [locationArray count];
    CLLocationCoordinate2D *coordinateArray = (CLLocationCoordinate2D *)malloc(pointCount * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < pointCount; ++i) {
        CLLocation *location = [locationArray objectAtIndex:i];
        coordinateArray[i] = [location coordinate];
    }
    
    self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:pointCount];
    
    //    [self.mapView setVisibleMapRect:[self.routeLine boundingMapRect]];
    [mapView addOverlay:self.routeLine];
    [self.lines addObject:self.routeLine];
    free(coordinateArray);
    coordinateArray = NULL;
}


- (MKPolylineRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if(overlay == self.routeLine) {
        
        self.routeLineView = [[MKPolylineRenderer alloc] initWithPolyline:self.routeLine];
        self.routeLineView.fillColor = [UIColor redColor];
        self.routeLineView.strokeColor = [UIColor redColor];
        self.routeLineView.lineWidth = 5;
        
        return self.routeLineView;
    }
    return nil;
}

- (void)drawTestLine
{
    NSMutableArray *sortOflot = [NSMutableArray arrayWithArray:pointAry];
    for (int j=0; j<pointAry.count; j++) {
        for (int i=(int)pointAry.count-1;i>0;i--) {
            MovePoint *a = sortOflot[i];
            MovePoint *b = sortOflot[i-1];
            if (a.lot < b.lot) {
                [sortOflot exchangeObjectAtIndex:i withObjectAtIndex:i-1];
            }
        }
    }
    
    NSMutableArray *sortOflat = [NSMutableArray arrayWithArray:pointAry];
    for (int j=0; j<pointAry.count; j++) {
        for (int i=(int)pointAry.count-1;i>0;i--) {
            MovePoint *a = sortOflat[i];
            MovePoint *b = sortOflat[i-1];
            if (a.lat < b.lat) {
                [sortOflat exchangeObjectAtIndex:i withObjectAtIndex:i-1];
            }
        }
    }
    
    MovePoint *point_lot_max = [sortOflot lastObject];
    MovePoint *point_lot_min = [sortOflot firstObject];
    MovePoint *point_lat_max = [sortOflat lastObject];
    MovePoint *point_lat_min = [sortOflat firstObject];
    
    
    NSMutableArray *pointMutableAry = [NSMutableArray array];
    for (int i=0; i<pointAry.count; i++) {
        MovePoint *point = pointAry[i];
        CLLocation *clPoint = [[CLLocation alloc] initWithLatitude:point.lat longitude:point.lot];
        [pointMutableAry addObject:clPoint];
    }
    
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta = (point_lat_max.lat - point_lat_min.lat)*1.2;
    theSpan.longitudeDelta = (point_lot_max.lot - point_lot_min.lot)*1.2;
    MKCoordinateRegion theRegion;
    
    CLLocation *center = [[CLLocation alloc] initWithLatitude:(point_lat_max.lat + point_lat_min.lat)/2
                                                    longitude:(point_lot_max.lot + point_lot_min.lot)/2];
    
    theRegion.center = center.coordinate;
    theRegion.span=theSpan;
    [mapView setRegion:theRegion];
    
    [self drawLineWithLocationArray:pointMutableAry];
    
    
    MovePoint *startPoint = [pointAry firstObject];
    MovePoint *endPoint = [pointAry lastObject];
    
    MKPointAnnotation *startAno = [[MKPointAnnotation alloc] init];
    startAno.title = @"起";
    
    startAno.coordinate = CLLocationCoordinate2DMake(startPoint.lat, startPoint.lot);
    [mapView addAnnotation:startAno];
     
    
    MKPointAnnotation *endAno = [[MKPointAnnotation alloc] init];
    endAno.title = @"终";
    endAno.coordinate = CLLocationCoordinate2DMake(endPoint.lat, endPoint.lot);
    [mapView addAnnotation:endAno];
}  

- (void)requestPoints{
    //[SVProgressHUD showWithStatus:@"正在获取路径点"];
//    NSString *urlStr = [NSString stringWithFormat:@"%@id=%ld",API_DEV_URL(@"api/move/blocks?"),(long)self.move.Id];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData *response = sendRequestWithFullURLAndPost(urlStr, nil);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSDictionary *returnDic = parseJsonResponse(response);
//            NSInteger res = [[returnDic objectForKey:@"result"] integerValue];
//            if (!response || !returnDic || !res) {
//                NSLog(@"move路径获取失败");
//                [SVProgressHUD dismiss];
//                [SVProgressHUD showErrorWithStatus:@"请求错误，获取失败"];
//
//                return;
//            }
//
//            NSMutableArray *array = [NSMutableArray array];
//            NSArray *ary = [[returnDic objectForKey:@"data"] objectForKey:@"blocks"];
//            for (int i=0; i<ary.count; i++) {
//                NSDictionary *obj = (NSDictionary *)ary[i];
//                MovePoint *point = [[MovePoint alloc] init];
//                point.lot = [[obj objectForKey:@"lot"] doubleValue];
//                point.lat = [[obj objectForKey:@"lat"] doubleValue];
//                [array addObject:point];
//            }
//            pointAry = array;
//
//            [self drawTestLine];
//            [SVProgressHUD dismiss];
//        });
//    });
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPath = [documentsPath stringByAppendingPathComponent:LOG_Loc];
    BOOL exist = [[[NSFileManager alloc] init] fileExistsAtPath:strPath];
    if (exist) {
        NSString *pathStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
        pathStr = [pathStr stringByAppendingString:@"]"];
        pathStr = [@"[" stringByAppendingString:pathStr];
        
        pointAry = [NSArray yy_modelArrayWithClass:[MovePoint class] json:[NSJSONSerialization JSONObjectWithData:[pathStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil]];
        [self drawTestLine];
    }else{
        [SVProgressHUD showInfoWithStatus:@"未记录任何定位信息"];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKAnnotationView *view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"point"];
    if ([annotation.title isEqualToString:@"起"]) {
        view.image = [UIImage imageNamed:@"start"];
    }
    else if ([annotation.title isEqualToString:@"终"]){
        view.image = [UIImage imageNamed:@"end"];
    }
    view.centerOffset = CGPointMake(0, -CGRectGetHeight(view.frame)/2);
    return view;
}

@end
