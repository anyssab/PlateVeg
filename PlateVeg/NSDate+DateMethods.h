//
//  NSDate+DateMethods.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 7/30/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <math.h>


@interface NSDate (DateMethods)
+(NSString *) getDateString : (NSDate*) date;
+(NSDate*) getDateFromString : (NSString* ) str;
+(NSInteger) diffInDays: (NSDate*) date1 : (NSDate*) date2;
+(NSInteger) getOldestDateIndex: (NSDate*) date1 : (NSDate*) date2 : (NSDate*) date3;
+(BOOL) secondDateIsNewer: (NSDate*) date1 : (NSDate*) date2;

@end
