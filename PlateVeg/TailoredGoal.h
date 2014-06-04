//
//  TailoredGoal.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/15/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Packet.h"

@interface TailoredGoal : Packet <NSCoding>{
@private
    NSNumber *status;
    NSNumber *tailored_goal_id;
    NSString *content;
    NSString *discussedTime;
    NSString *activeTime;
    NSString *achievedTime;
}

-(id) init: (NSNumber *) status_ : (NSNumber *) tailored_goal_id_ : (NSString *) content_ :  (NSString *) discussedTime_ :  (NSString *) activeTime_ : (NSString *) achievedTime_;
-(id) init: (NSDictionary *) dict;
-(NSString *) toString;
-(void) setStatus:(NSNumber *)status_ ;
-(void) setTailored_goal_id:(NSNumber *)tailored_goal_id_;
-(void) setContent:(NSString *)content_;
-(void) setDiscussedTime:(NSString *)discussedTime_;
-(void) setActiveTime:(NSString *)activeTime_;
-(void) setAchievedTime:(NSString *)achievedTime_;
-(NSNumber*) getTailored_goal_id;
-(NSNumber*) getStatus;
-(NSString*) getContent;
-(NSString*) getDiscussedTime;
-(NSString*) getActiveTime;
-(NSString*) getAchievedTime;
@end
