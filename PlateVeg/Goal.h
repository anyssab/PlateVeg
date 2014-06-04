//
//  Goal.h
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Packet.h"
#import "Intake.h"

@interface Goal : Packet {
    /** &&& Goal readings &&& */
	@private
    Intake *intakeGoal;
	NSNumber *pdmGoal;
	NSNumber *bcmGoal;
	NSNumber *bpmGoal; // Systolic only
	/** &&& EOF Goal readings &&& */
}

-(id) init: (Intake *) intakegoal : (NSNumber *) pdmGoal :(NSNumber *) bcmGoal :(NSNumber *) bpmGoal :(NSString *) date;
-(id) init: (NSDictionary *) dict;

-(NSString *) toString;

-(NSString *) string;
-(Intake*) getIntakeGoal;
-(void) setIntakeGoal:(Intake *) intakeGoal_;
-(NSNumber *) getPdmGoal;
-(void) setPdmGoal:(NSNumber *) pdmGoal_;
-(NSNumber *) getBcmGoal;
-(void) setBcmGoal:(NSNumber *) bcmGoal_;
-(NSNumber *) getBpmGoal;
-(void) setBpmGoal:(NSNumber *) bpmGoal_;


-(NSDictionary *) getDictionary;
@end
