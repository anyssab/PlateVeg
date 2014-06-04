//
//  Msg.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/15/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Msg.h"
@interface Msg ()
@property (nonatomic) NSNumber *from;
@property (nonatomic) NSNumber *to;
@property (nonatomic) NSString *text;
@property (nonatomic) NSNumber *resourceID;
@property (nonatomic) NSString *typeOfPacket;
@end

@implementation Msg
@synthesize from, to, text, resourceID;

-(id) init: (NSNumber *) from_ : (NSNumber *) to_ :  (NSString *) text_ :  (NSNumber *) resourceID_{
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"Msg"];
        from = from_;
        to = to_;
        text = text_;
        resourceID = resourceID_;
    }
    return self;
}

-(id) init: (NSDictionary *) dict {
    if (self = [super init]) {
        [super setTypeOfPacket:@"Msg"];
        from = [dict objectForKey:@"from"];
        to = [dict objectForKey:@"to"];
        text = [dict objectForKey:@"text"];
        resourceID = [dict objectForKey:@"resourceID"];
        
    }
    return self;
}

-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:self];
    NSString *jsonString = [writer stringWithObject:dict];
    return jsonString;
}

-(void) setFrom:(NSNumber *)from_ {
    from = from_;
}

-(void) setTo:(NSNumber *)to_ {
    to = to_;
}

-(void) setText:(NSString *)text_ {
    text = text_;
}

-(void) setResourceID:(NSNumber *)resourceID_ {
    resourceID = resourceID_;
}

-(NSNumber*) getFrom {
    return from;
}

-(NSNumber*) getTo {
    return to;
}

-(NSString*) getText {
    return text;
}

-(NSNumber*) getResourceID {
    return resourceID;
}


- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:from forKey:@"from"];
    [coder encodeObject:to forKey:@"to"];
    [coder encodeObject:text forKey:@"text"];
    [coder encodeObject:resourceID forKey:@"resourceID"];
    [coder encodeObject:typeOfPacket forKey:@"typeOfPacket"];

//    [coder encodeObject:date forKey:@"date"];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [super setTypeOfPacket:[decoder decodeObjectForKey:@"typeOfPacket"]];
        [self setFrom: [decoder decodeObjectForKey:@"from"]];
        [self setTo: [decoder decodeObjectForKey:@"to"]];
        [self setText: [decoder decodeObjectForKey:@"text"]];
        [self setResourceID: [decoder decodeObjectForKey:@"resourceID"]];
//      [super setDate: [decoder decodeObjectForKey:@"date"]];
    }
    return self;
}
@end
