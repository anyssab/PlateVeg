//
//  MsgObject.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/28/13.
//  Copyright (c) 2013 BU. All rights reserved.
//

#import "MsgObject.h"

@implementation MsgObject
@synthesize sent,value, msgIndex;

-(id) init {
    if (self = [super init]) {
        sent = [[NSNumber alloc] init];
        value = [[Msg alloc] init];
        msgIndex = [[NSNumber alloc] init];
    }
    return self;
}

-(id) initWithData: (Msg *) value_ : (NSNumber *) sent_ : (NSNumber *) msgIndex_{
    if (self = [super init]) {
        sent = sent_;
        value = value_;
        msgIndex = msgIndex_;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:value forKey:@"value"];
    [coder encodeObject:sent forKey:@"sent"];
    [coder encodeObject:msgIndex forKey:@"msgIndex"];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        value = [decoder decodeObjectForKey:@"value"];
        sent = [decoder decodeObjectForKey:@"sent"];
        msgIndex = [decoder decodeObjectForKey:@"msgIndex"];

    }
    return self;
}
@end
