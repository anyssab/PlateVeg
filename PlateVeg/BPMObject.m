//
//  BPMObject.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 7/30/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "BPMObject.h"

@implementation BPMObject
@synthesize date,value,sent;

-(id) init {
    if (self = [super init]) {
        date = [[NSDate alloc] init];
        value = [[Bpm alloc]init];
        sent = NO;
    }
    return self;
}

-(id) initWithData: (Bpm*) value_ : (NSDate *) date_ {
    if (self = [super init]) {
        date = date_;
        value = value_;
        sent = NO;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:value forKey:@"value"];
    [coder encodeObject:date forKey:@"date"];
    [coder encodeBool:sent forKey:@"sent"];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        value = [decoder decodeObjectForKey:@"value"];
        date = [decoder decodeObjectForKey:@"date"];
        sent = [decoder decodeBoolForKey:@"sent"];
    }
    return self;
}
@end
