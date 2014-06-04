
//
//  Packet.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
// Just a conversion from server java code


#import "Packet.h"


@interface Packet()

@property (nonatomic, retain) NSString *typeOfPacket;
@property (nonatomic) NSString *date;
@property (nonatomic) NSString *packetId;
//@property (nonatomic) NSString *requestType;
//@property (nonatomic) Ptype requestType; // For server back to client. so that the client knows which day/type that ack is from.
@property (nonatomic) NSString *storedDay; // For client's tracking of days.

@end

@implementation Packet
@synthesize typeOfPacket,date,packetId,storedDay;


-(id) init {
    if (self = [super init] ) {
        self.typeOfPacket = [NSString alloc];
        self.date = [NSString alloc];
        self.packetId = [NSString alloc];
        self.storedDay = [NSString alloc];
    }
    return self;
}


-(NSString *) toString{
    return NULL;
}

-(NSDictionary *) getDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}
//
//-(Ptype) getTypeOfPacket {
//    return typeOfPacket;
//}
//
//-(void) setTypeOfPacket: (Ptype) typeOfPacket_ {
//
//    typeOfPacket = typeOfPacket_;
//}
-(NSString *) getTypeOfPacket {
    return typeOfPacket;
}

-(void) setTypeOfPacket: (NSString *) typeOfPacket_ {
    
    typeOfPacket = typeOfPacket_;
}


-(NSString *)getDate {
    return date;
}

-(void) setDate: (NSString *) date_ {
    date = date_;
}


-(NSString *) getPacketId {
    return packetId;
}

-(void) setPacketId:(NSString *) packetId_ {
    packetId = packetId_;
}

//-(Ptype) getRequestType {
//    return requestType;
//}
//
//-(void) setRequestType:(Ptype) requestType_ {
//    requestType = requestType_;
//}

-(NSString*) getStoredDay {
    return storedDay;
}

-(void) setStoredDay:(NSString *) storedDay_ {
    storedDay = storedDay_;
}


@end
