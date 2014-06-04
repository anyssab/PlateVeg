//
//  IOSEnrollment.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/21/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "IOSEnrollment.h"

@interface IOSEnrollment ()
@property (nonatomic) NSString *device_id;
@property (nonatomic) NSString *typeOfPacket;

@end

@implementation IOSEnrollment
@synthesize device_id;

-(id) init: (NSString *) device_id_{
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"IOSENROLLMENT"];
        device_id = device_id_;
    }
    return self;
}

-(id) initWithDict: (NSDictionary *) dict {
    if (self = [super init]) {
        [super setTypeOfPacket:@"IOSENROLLMENT"];
        device_id = [dict objectForKey:@"device_id"];
    }
    return self;
}

-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:self];
    NSString *jsonString = [writer stringWithObject:dict];
    return jsonString;
}

-(void) setDevice_id:(NSString *)device_id_ {
    device_id = device_id_;
}

-(NSString *) getDevice_id {
    return device_id;
}


- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:device_id forKey:@"device_id"];
    [coder encodeObject:typeOfPacket forKey:@"typeOfPacket"];
    
    //    [coder encodeObject:date forKey:@"date"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [super setTypeOfPacket:[decoder decodeObjectForKey:@"typeOfPacket"]];
        [self setDevice_id:[decoder decodeObjectForKey:@"device_id"]];
    }
    return self;
}
@end
