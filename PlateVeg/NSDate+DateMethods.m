//
//  NSDate+DateMethods.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 7/30/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "NSDate+DateMethods.h"


@implementation NSDate (DateMethods)


+(NSString *) getDateString : (NSDate*) date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat stringFromDate:date];
}

+(NSInteger) diffInDays: (NSDate*) date1 : (NSDate*) date2  {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    date1 = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:date1]];
    date2 = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:date2]];

//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSDayCalendarUnit
                                               fromDate:date1
                                                 toDate:date2
                                                options:0];
//    NSLog(@"DAY COMPONENTS %d",components.day);
//    NSTimeInterval interval1 = [date1 timeIntervalSince1970];
//    NSTimeInterval interval2 = [date2 timeIntervalSince1970];
//    NSTimeInterval dateDiff = abs(interval1 - interval2);
//    
//    NSTimeInterval retVal = dateDiff/(24 * 60 * 60);
//    
//    if (retVal > (NSInteger)retVal) {
//        retVal = (NSInteger)retVal+1;
//    }
//    NSLog(@"DIFFERENCE IN DATE: %f",);
    return abs(components.day);
}

+(BOOL) secondDateIsNewer: (NSDate*) date1 : (NSDate*) date2  {
    if( [date1 timeIntervalSinceDate:date2] > 0 ) {
        return NO;
    } else {
        return YES;
    }
}

+(NSDate*) getDateFromString : (NSString* ) str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];

    NSDate *date = [formatter dateFromString:str];

    return date;
}


+(NSInteger) getOldestDateIndex: (NSDate*) date1 : (NSDate*) date2 : (NSDate*) date3 {
    NSDate* oldestDate;
    NSInteger oldestDateIndex;
    
    NSLog(@"DATE 1: %@", date1);
    NSLog(@"DATE 2: %@", date2);
    NSLog(@"DATE 3: %@", date3);

    switch ([date1 compare:date2]) {
        case NSOrderedAscending:
            oldestDate = date1;
            oldestDateIndex = 0;
            break;
        case NSOrderedSame:
            NSLog(@"Well, this is awkward part 1");
            oldestDate = date1;
            oldestDateIndex = 0;
            break;
        case NSOrderedDescending:
            oldestDate = date2;
            oldestDateIndex = 1;
            break;
    }
    
    switch ([oldestDate compare:date3]) {
        case NSOrderedAscending:
            //oldestDate already oldestDate
            break;
        case NSOrderedSame:
            NSLog(@"Well, this is awkward part 2");
            break;
        case NSOrderedDescending:
            oldestDateIndex = 2;
            break;
    }
    return oldestDateIndex;
}
@end
