//
//  Inq.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"
#import "Tracking.h"

//typedef enum iNQ {
//    INTAKE,
//    TRACKING,
//    GOAL
//} INQ;

@interface Inq : Packet {
    @private
//    INQ type;
    NSString *type;
    
    // OPTIONAL. ONLY needed for TRACKING
    NSString *ttype;

     // OPTIONAL. ONLY needed for PROGRESSDATA
    NSString *requestType;
    NSUInteger period;
    
//	TrackingType ttype;
	// EOF OPTIONAL
	
	// OPTIONAL. ONLY needed for GOAL.
	NSNumber *weight;
	NSNumber *height;
	NSNumber *age;
	NSNumber *gender;
	NSNumber *maintainWeight;
	// EOF OPTIONAL
    
    NSNumber *pull_id;

	
}

-(id) init: (NSString *) type_;
-(id) initIntake: (NSString *) type_ : (NSString *) date_;
-(id) initTracking: (NSString *) type_ : (NSString *) ttype_;
-(id) initGoal: (NSString *) type_ : (NSNumber *) weight_ : (NSNumber *) height_ : (NSNumber *) age_ : (NSNumber *) gender_ : (NSNumber *) maintainWeight_;
-(id) initProgressData: (NSString *) type_ : (NSString *) requestType_ : (NSUInteger) period_;
-(id) initPull: (NSString *) type_ : (NSString *) requestType_ : (NSNumber *) pull_id_;
-(id) initUnread: (NSString *) type_ : (NSString *) requestType_;

-(NSString *) toString;
-(NSString *) getType;
-(void) setType: (NSString *) type_;
-(NSNumber *) getWeight;
-(void) setWeight:(NSNumber *)weight_;
-(NSNumber *)getHeight;
-(void) setHeight:(NSNumber *) height_;
-(NSNumber *) getAge;
-(void) setAge: (NSNumber *)age_;
-(NSNumber *) getGender;
-(void) setGender: (NSNumber *) gender_;
-(void) setMaintainWeight: (NSNumber *) maintainWeight_;
-(NSNumber *) getMaintainWeight;
//-(NSString *) getTtype;
-(void) setTtype:(NSString *) ttype_;

-(NSNumber *) getPull_id;
-(void) setPull_id:(NSNumber *)pull_id_;

@end
