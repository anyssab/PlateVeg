//
//  Bcm+Encoding.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/2/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Bcm+Encoding.h"

@implementation Bcm (Encoding)


- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:weight forKey:@"weight"];
    [coder encodeObject:typeOfPacket forKey:@"typeOfPacket"];
    [coder encodeObject:date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [super setTypeOfPacket:[decoder decodeObjectForKey:@"typeOfPacket"]];
        [self setWeight:[decoder decodeObjectForKey:@"weight"]];
        [super setDate: [decoder decodeObjectForKey:@"date"]];
    }
    return self;
}

@end
