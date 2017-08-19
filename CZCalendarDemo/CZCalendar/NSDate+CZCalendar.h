//
//  NSDate+CZCalendar.h
//  CZCalendarDemo
//
//  Created by Clay Zhu on 2017/8/16.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DayToShowModel;

@interface NSDate (CZCalendar)

/** 年月日时分秒 */
- (NSDateComponents *)dateComponents;

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
- (NSInteger)weekday;

/** 获取 self 对应月份的天数 */
- (NSInteger)numberOfDaysInMonth;
/** 获取 self 对应月份的第一天 */
- (NSDate *)firstDayOfMonth;
/** 获取 self 对应月份的第一天是周几，从1-周日开始 */
- (NSInteger)firstWeekdayOfMonth;

/**
 以 self 对应的月份为基准，计算相邻的月份的 NSDate 数据

 @param offsetNumber 月份偏移量，以 self 对应的月份为0，负数表示计算过去的月份，正数表示计算未来的月份
 @return 相邻的月份的 NSDate 数据
 */
- (NSDate *)adjacentMonthWithOffsetNumber:(NSInteger)offsetNumber;
/** 计算 self 对应月份的日子，显示日历的一页，以周日开头按星期排序，包括：上个月的最后几天、这个月的日子、下个月的开始几天 */
- (NSArray<DayToShowModel *> *)daysInMonthToShowForCalendar;

@end

/**
 显示在日历的一页中的日子的时期

 - DayToShowPeriodLastMonth: 上个月的最后几天
 - DayToShowPeriodThisMonth: 这个月的日子
 - DayToShowPeriodNextMonth: 下个月的开始几天
 */
typedef NS_ENUM(NSUInteger, DayToShowPeriod) {
    DayToShowPeriodLastMonth,
    DayToShowPeriodThisMonth,
    DayToShowPeriodNextMonth,
};

@interface DayToShowModel : NSObject

@property (assign, nonatomic) DayToShowPeriod dayToShowPeriod;
@property (assign, nonatomic) NSInteger day;
@property (assign, nonatomic, getter=isToday) BOOL today;

@end
