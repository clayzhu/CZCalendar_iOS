//
//  NSDate+CZCalendar.m
//  CZCalendarDemo
//
//  Created by Clay Zhu on 2017/8/16.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "NSDate+CZCalendar.h"

@implementation NSDate (CZCalendar)

- (NSInteger)year {
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return dateComponent.year;
}

- (NSInteger)month {
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return dateComponent.month;
}

- (NSInteger)day {
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return dateComponent.day;
}

- (NSInteger)hour {
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return dateComponent.hour;
}

- (NSInteger)minute {
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return dateComponent.minute;
}

- (NSInteger)second {
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return dateComponent.second;
}

- (NSInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return dateComponent.weekday;
}

- (NSInteger)numberOfDaysInMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSDate *)firstDayOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    dateComponent.day = 1;
    NSDate *firstDayOfMonth = [calendar dateFromComponents:dateComponent];
    return firstDayOfMonth;
}

- (NSInteger)firstWeekdayOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 设置每周的第一天从周几开始，默认为1，从周日开始
    calendar.firstWeekday = 1;  // 1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *dateComponent = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    dateComponent.day = 1;
    NSDate *firstDayOfMonth = [calendar dateFromComponents:dateComponent];
    NSInteger firstWeekdayOfMonth = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonth];
    return firstWeekdayOfMonth;
}

@end
