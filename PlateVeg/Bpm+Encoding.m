//
//  Bpm+Encoding.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/5/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Bpm+Encoding.h"

@implementation Bpm (Encoding)

- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:typeOfPacket forKey:@"typeOfPacket"];
    [coder encodeObject:systolic forKey:@"systolic"];
    [coder encodeObject:diastolic forKey:@"diastolic"];
    [coder encodeObject:map forKey:@"map"];
    [coder encodeObject:pulse forKey:@"pulse"];
    [coder encodeObject:date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [super setTypeOfPacket:[decoder decodeObjectForKey:@"typeOfPacket"]];
        [self setSystolic:[decoder decodeObjectForKey:@"systolic"]];
        [self setDiastolic:[decoder decodeObjectForKey:@"diastolic"]];
        [self setMap:[decoder decodeObjectForKey:@"map"]];
        [self setPulse:[decoder decodeObjectForKey:@"pulse"]];
        [super setDate: [decoder decodeObjectForKey:@"date"]];
    }
    return self;
}
@end
