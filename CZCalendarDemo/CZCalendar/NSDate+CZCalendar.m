//
//  NSDate+CZCalendar.m
//  CZCalendarDemo
//
//  Created by Clay Zhu on 2017/8/16.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "NSDate+CZCalendar.h"

@implementation NSDate (CZCalendar)

- (NSDateComponents *)dateComponents {
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    return dateComponents;
}

- (NSInteger)year {
    NSDateComponents *dateComponents = [self dateComponents];
    return dateComponents.year;
}

- (NSInteger)month {
    NSDateComponents *dateComponents = [self dateComponents];
    return dateComponents.month;
}

- (NSInteger)day {
    NSDateComponents *dateComponents = [self dateComponents];
    return dateComponents.day;
}

- (NSInteger)hour {
    NSDateComponents *dateComponents = [self dateComponents];
    return dateComponents.hour;
}

- (NSInteger)minute {
    NSDateComponents *dateComponents = [self dateComponents];
    return dateComponents.minute;
}

- (NSInteger)second {
    NSDateComponents *dateComponents = [self dateComponents];
    return dateComponents.second;
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

- (NSDate *)adjacentMonthWithOffsetNumber:(NSInteger)offsetNumber {
    if (offsetNumber == 0) {    // 若月份偏移量为0，直接返回基准月份的数据
        return self;
    }
    NSDateComponents *dateComponents = [self dateComponents];
    NSInteger offsetYear = abs(offsetNumber) / 12;   // 计算月份偏移量是否大于一年
    NSInteger nowMonth = dateComponents.month;
    NSInteger offsetMonth = nowMonth + offsetNumber;
    // 计算偏移后的年份
    if (offsetMonth <= 0) { // 计算偏移后的月份为0，表示上一年的12月
        dateComponents.year -= (offsetYear + 1);
    } else {
        if (offsetMonth > 12) { // 计算偏移
            dateComponents.year += (offsetYear + 1);
        }
    }
    // 计算偏移后的月份
    NSInteger newMonth = (offsetMonth + 12 * (offsetYear + 1)) % 12;
    dateComponents.month = newMonth == 0 ? 12 : newMonth;
    // 日子设置为1号
    dateComponents.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    return newDate;
}

- (NSArray<DayToShowModel *> *)daysInMonthToShowForCalendar {
    NSMutableArray<DayToShowModel *> *daysToShowMA = [NSMutableArray array];
    NSInteger numberOfDaysInMonth = [self numberOfDaysInMonth]; // NSDate 对应月份的天数
    NSInteger firstWeekdayOfMonth = [self firstWeekdayOfMonth]; // NSDate 对应月份的第一天是周几
    // 需要显示42个日子的情况：该月有31天，且该月第一天是周五；或者，该月有30或31天，且第一天是周六；需要显示28个日子的情况：该月有28天，且该月第一天是周日
    NSInteger numberOfDaysToShow;
    if ((numberOfDaysInMonth == 31 && firstWeekdayOfMonth == 6) || ((numberOfDaysInMonth >= 30) && firstWeekdayOfMonth == 7)) {
        numberOfDaysToShow = 42;
    } else if (numberOfDaysInMonth == 28 && firstWeekdayOfMonth == 1) {
        numberOfDaysToShow = 28;
    } else {
        numberOfDaysToShow = 35;
    }
    // 补全1号前的日子（上个月的最后几天）
    NSDate *lastMonthDate = [self adjacentMonthWithOffsetNumber:-1];
    NSInteger numberOfDaysInLastMonth = [lastMonthDate numberOfDaysInMonth]; // 上个月的天数
    for (NSInteger i = numberOfDaysInLastMonth - (firstWeekdayOfMonth - 1); i < numberOfDaysInLastMonth; i ++) {
        DayToShowModel *model = [[DayToShowModel alloc] init];
        model.dayToShowPeriod = DayToShowPeriodLastMonth;
        model.day = i + 1;
        [daysToShowMA addObject:model];
    }
    // 该月的日子
    NSDateComponents *thisDateComponents = [self dateComponents];
    NSDateComponents *nowDateComponents = [[NSDate date] dateComponents];
    for (NSInteger j = 0; j < numberOfDaysInMonth; j ++) {
        DayToShowModel *model = [[DayToShowModel alloc] init];
        model.dayToShowPeriod = DayToShowPeriodThisMonth;
        model.day = j + 1;
        if (thisDateComponents.year == nowDateComponents.year && thisDateComponents.month == nowDateComponents.month && nowDateComponents.day == j + 1) {   // self 对应的月份正好是当月，则寻找到今天的日子
            model.today = YES;
        }
        [daysToShowMA addObject:model];
    }
    // 提前补充下个月的开始几天
    NSInteger numberOfDaysInNextMonthBeginning = numberOfDaysToShow - numberOfDaysInMonth - (firstWeekdayOfMonth - 1);
    for (NSInteger k = 0; k < numberOfDaysInNextMonthBeginning; k ++) {
        DayToShowModel *model = [[DayToShowModel alloc] init];
        model.dayToShowPeriod = DayToShowPeriodNextMonth;
        model.day = k + 1;
        [daysToShowMA addObject:model];
    }
    return daysToShowMA;
}

@end

@implementation DayToShowModel

@end
