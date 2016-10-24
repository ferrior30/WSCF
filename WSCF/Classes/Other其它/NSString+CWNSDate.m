//
//  NSString+CWNSDate.m
//  WSCF
//
//  Created by ChenWei on 16/10/23.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "NSString+CWNSDate.h"

struct weekday {
    NSInteger usaWeekday;
    char *chineseWeekday;
}weekdayTable[] = {
    {0, NULL},
    {1,"周日"},
    {2,"周一"},
    {3,"周二"},
    {4,"周三"},
    {5,"周四"},
    {6,"周五"},
    {7, "周六"},
};

@implementation NSString (CWNSDate)
+ (instancetype)cw_stringWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit =  NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDateComponents *cmp = [calendar components:unit fromDate:date];
    
    if (cmp.minute + 30 >= 60) {
        cmp.hour +=1;
        cmp.minute = (cmp.minute + 30) / 60;
    }else cmp.hour +=1;
    
    NSString *weekDayString = [NSString stringWithUTF8String:weekdayTable[cmp.weekday].chineseWeekday];
    return [NSString stringWithFormat:@"%ld月%ld日 %@ %02ld:%02ld-%02ld:%02ld", (long)cmp.month, (long)cmp.day, weekDayString, (long)cmp.hour, (long)cmp.minute,(long)cmp.hour + 1, (long)cmp.minute + 30];
    
}
@end
