//
//  DisLog.m
//  Distance
//
//  Created by zhangxintao on 2019/11/7.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "DisLog.h"

@implementation DisLog

+ (BOOL)WriteLocate:(NSString *)log{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *content = log;
    NSString *strPath = [documentsPath stringByAppendingPathComponent:LOG_Loc];
    BOOL exist = [[[NSFileManager alloc] init] fileExistsAtPath:strPath];
    BOOL isOk = NO;
    if (!exist) {
        // 2.创建要存储的内容：字符串
        isOk = [content writeToFile:strPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSString *newStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@", newStr);
    }else{
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:strPath];
        [fileHandle seekToEndOfFile];
        NSString *addStr = [NSString stringWithFormat:@",%@",content];
        [fileHandle writeData:[addStr dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
        
        NSString *newStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@", newStr);
    }
    
    return isOk;
}

+ (BOOL)Write:(NSString *)log To:(NSString *)file{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *content = log;
    NSString *strPath = [documentsPath stringByAppendingPathComponent:file];
    BOOL exist = [[[NSFileManager alloc] init] fileExistsAtPath:strPath];
    NSString *str = @"";
    BOOL isOk = NO;
    if (!exist) {
        // 2.创建要存储的内容：字符串
        str = [NSString stringWithFormat:@"%@-------记录日志-------%@",stringOfDate([NSDate date]),content];
        isOk = [str writeToFile:strPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSString *newStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@", newStr);
    }else{
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:strPath];
        [fileHandle seekToEndOfFile];
        NSString *addStr = [NSString stringWithFormat:@"\n\n%@-------记录日志-------%@",stringOfDate([NSDate date]),content];
        [fileHandle writeData:[addStr dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
        
        NSString *newStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@", newStr);
    }
    
    return isOk;
}

+ (BOOL)clearLog{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPath = [documentsPath stringByAppendingPathComponent:@"log.txt"];
    BOOL exist = [[[NSFileManager alloc] init] fileExistsAtPath:strPath];
    if (exist) {
        return [[[NSFileManager alloc] init] removeItemAtPath:strPath error:nil];
    }else{
        return YES;
    }
}

@end
