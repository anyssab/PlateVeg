//
//  GoalObject.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/1/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "GoalObject.h"

@implementation GoalObject
@synthesize date,value;

-(id) init {
    if (self = [super init]) {
        date = [[NSDate alloc] init];
        value = [[Intake alloc] init];
    }
    return self;
}

-(id) initWithData: (Intake *) value_ : (NSDate *) date_ {
    if (self = [super init]) {
        date = date_;
        value = value_;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:value forKey:@"value"];
    [coder encodeObject:date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        value = [decoder decodeObjectForKey:@"value"];
        date = [decoder decodeObjectForKey:@"date"];
    }
    return self;
}
@end
