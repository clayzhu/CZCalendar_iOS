# CZCalendar_iOS
通过 NSCalendar 获取日历的信息，如当月共有多少天、第一天是星期几等。

## 介绍

NSCalendar 封装了对日历的各项信息，支持公历、农历等多种历法。

通过 `NSCalendarUnit` 的不同组合，配合 `NSDate` 的时间，可以获取到与日历相关的很多信息。但若每次都做一遍组合，代码显得冗余，流程上也很麻烦。

`CZCalendar_iOS` 是基于 `NSDate` 的一个 Category，能通过 `NSDate` 便利地得到年月日等基本信息，也能计算出对应月份的天数等。

