//
//  Msg.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/15/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Packet.h"

@interface Msg : Packet <NSCoding> {
@private
    NSNumber *from;
    NSNumber *to;
    NSString *text;
    NSNumber *resourceID;
}

-(id) init: (NSNumber *) from_ : (NSNumber *) to_ :  (NSString *) text_ :  (NSNumber *) resourceID_;

-(id) init: (NSDictionary *) dict;
-(NSString *) toString;
-(void) setFrom:(NSNumber *)from_;
-(void) setTo:(NSNumber *)to_;
-(void) setText:(NSString *)text_;
-(void) setResourceID:(NSNumber *)resourceID_;
-(NSNumber*) getFrom;
-(NSNumber*) getTo;
-(NSString*) getText;

-(NSNumber*) getResourceID;

@end
