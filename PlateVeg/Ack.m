//
//  Ack.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Ack.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"

@interface Ack()
//@property (nonatomic) Opcode opCode;
//@property (nonatomic) Reason reason;
@property (nonatomic, retain) NSString *opCode;
@property (nonatomic, retain) NSString *reason;
@property (nonatomic) NSString *typeOfPacket;
@end

@implementation Ack

-(id) init: (NSString *) op :(NSString *) r {
    if ( self = [super init] ) {
        super.typeOfPacket = @"ACK";
        opCode = op;
        reason = r;
    }
    return self;
}

-(id) init: (NSDictionary *) dict {
    if (self = [super init]) {
        super.typeOfPacket = @"ACK";
        opCode = [dict objectForKey:@"opCode"];
        reason = [dict objectForKey:@"reason"];
//        NSLog(@"DICT: %@", dict);
    }
    return self;
}


/**
 * FOR JSON Messing
 * */
-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:self];
    
    NSString *jsonString = [writer stringWithObject:dict];
    
    
    return jsonString;
}

-(NSDictionary *) getDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}

-(NSString *) getOpCode {
    return opCode;
}

-(NSString *) getReason {
    return reason;
}


@end
