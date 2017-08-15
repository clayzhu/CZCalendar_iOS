//
//  NSDate+CZCalendar.h
//  CZCalendarDemo
//
//  Created by Clay Zhu on 2017/8/16.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CZCalendar)

/** 年 */
- (NSInteger)year;
/** 月 */
- (NSInteger)month;
/** 日 */
- (NSInteger)day;
/** 时 */
- (NSInteger)hour;
/** 分 */
- (NSInteger)minute;
/** 秒 */
- (NSInteger)second;
/** 周几，从1-周日开始 */
- (NSUInteger)weekday;

/** 获取 NSDate 对应月份的天数 */
- (NSUInteger)numberOfDaysInMonth;
/** 获取 NSDate 对应月份的第一天 */
- (NSDate *)firstDayOfMonth;
/** 获取 NSDate 对应月份的第一天是周几 */
- (NSInteger)firstWeekdayOfMonth;

@end
