//
//  Packet.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"

/**
 * -1 = Exit/Goodbye/close the socket
 * 0 = ACK from Server // Responds from server
 * 1 = ACC // Verify Account Password
 * 2 = PDM Readings
 * 3 = BCM Readings
 * 4 = BPM Readings
 * 5 = Intake Readings
 * 6 = Tracking // See sub-types
 * 7 = Goal
 * 8 = INQ - Inquiry from client-to-Server. For: past Intake, Tracking, Goal
 * */

typedef enum ptype {
    EXIT,
    ACK,
    ACC,
    PDM,
    BCM,
    BPM,
    INTAKE,
    TRACKING,
    GOAL,
    INQ
} Ptype;

@interface Packet : NSObject {
@protected
    
    NSString *typeOfPacket;
    
    //    Ptype typeOfPacket;
	NSString *date;
    NSString *packetId;
	//Ptype requestType; // For server back to client. so that the client knows which day/type that ack is from.
	NSString *storedDay; // For client's tracking of days.
}



-(id) init;
-(NSString *) toString;
-(NSDictionary *) getDictionary;
-(NSString *) getTypeOfPacket;
-(void) setTypeOfPacket: (NSString *) typeOfPacket;
//-(Ptype) getTypeOfPacket;
//-(void) setTypeOfPacket: (Ptype) typeOfPacket;
-(NSString *)getDate;
-(void) setDate: (NSString *) date;
-(NSString *) getPacketId;
-(void) setPacketId:(NSString *) packetId;
//-(Ptype) getRequestType;
//-(void) setRequestType:(Ptype) requestType;
-(NSString*) getStoredDay;
-(void) setStoredDay:(NSString *) storedDay;

@end
