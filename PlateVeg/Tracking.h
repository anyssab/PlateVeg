//
//  Tracking.h
//  Test
//
//  Created by Ross Tang Him on 6/10/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"

typedef enum trackingType {
    TODAY, // For today's data only
    WEEK, // For past week's data
    MONTH, // For past Month's data
    SINCESTART // Since start
} TrackingType;

@interface Tracking : Packet {
    /*
	 * ERR = 0
	 * Green = 1
	 * Yellow = 2
	 * Red = 3
	 * **/
    @private
	NSNumber *_BP;
	NSNumber *_Steps;
	NSNumber *_Intake;
	NSNumber *_Weight;
    NSString *type;

//    TrackingType type;
}

-(id) init: (NSNumber *) BP : (NSNumber *) steps :  (NSNumber *) intake :  (NSNumber *) weight :  (NSNumber *) type_;
-(id) init: (NSDictionary *) dict;
-(NSString *) string;
-(NSString *) toString;
-(NSNumber *) get_BP;
-(void) set_BP:(NSNumber *) _BP_;
-(NSNumber *) get_Steps;
-(void) set_Steps:(NSNumber *) _Steps_;
-(NSNumber *) get_Intake;
-(void) set_Intake: (NSNumber *) _Intake_;
-(NSNumber *) get_Weight;
-(void) set_Weight:(NSNumber *) _Weight_;
//-(TrackingType) getType;
//-(void) setType:(TrackingType) type_;


@end
