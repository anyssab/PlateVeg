//
//  Bpm.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"

@interface Bpm : Packet {
    /** && BPM Readings &&& */
	@private
    NSNumber *systolic;
	NSNumber *diastolic;
	NSNumber *map;
	NSNumber *pulse;
//    NSString *typeOfPacket;
	/** && EOF BPM Readings &&& */
}

-(id) init: (NSNumber *) systolic_ : (NSNumber *) diastolic_ :(NSNumber *) map_ :(NSNumber *) pulse_ :(NSString *) date_;
-(NSString *) toString;
-(NSString *) string;
-(NSNumber *) getSystolic;
-(void) setSystolic: (NSNumber *)systolic_;
-(NSNumber *) getDiastolic;
-(void) setDiastolic:(NSNumber *) diastolic_;
-(NSNumber *) getMap;
-(void) setMap: (NSNumber *)map_;
-(NSNumber *) getPulse;
-(void) setPulse: (NSNumber *) pulse_;
-(NSDictionary *) getDictionary;
@end
