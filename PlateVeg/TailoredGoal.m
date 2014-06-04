//
//  TailoredGoal.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/15/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "TailoredGoal.h"

@interface TailoredGoal ()
@property (nonatomic) NSNumber *status;
@property (nonatomic) NSNumber *tailored_goal_id;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *discussedTime;
@property (nonatomic) NSString *activeTime;
@property (nonatomic) NSString *achievedTime;
@property (nonatomic) NSString *typeOfPacket;
@property (nonatomic) NSString *date;

@end

@implementation TailoredGoal
@synthesize status,tailored_goal_id,content,discussedTime,achievedTime,activeTime;

-(id) init: (NSNumber *) status_ : (NSNumber *) tailored_goal_id_ : (NSString *) content_ :  (NSString *) discussedTime_ :  (NSString *) activeTime_ : (NSString *) achievedTime_{
    if (self = [super init]) {
        [super setTypeOfPacket:@"TailoredGoal"];
        status = status_;
        tailored_goal_id = tailored_goal_id_;
        content = content_;
        discussedTime = discussedTime_;
        activeTime = activeTime_;
        achievedTime = achievedTime_;
        
        [super setDate:@"NIL"];
    }
    return self;
}

-(id) init: (NSDictionary *) dict {
    if (self = [super init]) {
        [super setTypeOfPacket:@"TailoredGoal"];
        status = [dict objectForKey:@"status"];
        tailored_goal_id = [dict objectForKey:@"tailored_goal_id"];
        content = [dict objectForKey:@"content"];
        discussedTime = [dict objectForKey:@"discussedTime"];
        activeTime = [dict objectForKey:@"activeTime"];
        if ([dict objectForKey:@"achievedTime"] && [dict objectForKey:@"achievedTime"] != NULL) {
            achievedTime = [dict objectForKey:@"achievedTime"];
        } else {
            achievedTime = @"";
        }
        [super setDate:@"NIL"];
    }
    return self;
}

-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:self];
    NSString *jsonString = [writer stringWithObject:dict];
    return jsonString;
}

-(void) setStatus:(NSNumber *)status_ {
    status = status_;
}

-(void) setTailored_goal_id:(NSNumber *)tailored_goal_id_ {
    tailored_goal_id = tailored_goal_id_;
}
-(void) setContent:(NSString *)content_ {
    content = content_;
}
-(void) setDiscussedTime:(NSString *)discussedTime_ {
    discussedTime =discussedTime_;
}
-(void) setActiveTime:(NSString *)activeTime_ {
    activeTime = activeTime_;
}
-(void) setAchievedTime:(NSString *)achievedTime_ {
    achievedTime = achievedTime_;
}
-(NSNumber*) getTailored_goal_id {
    return tailored_goal_id;
}

-(NSNumber*) getStatus {
    return status;
}
-(NSString*) getContent {
    return content;
}
-(NSString*) getDiscussedTime {
    return discussedTime;
}
-(NSString*) getActiveTime {
    return activeTime;
}
-(NSString*) getAchievedTime {
    return achievedTime;
}

- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:status forKey:@"status"];
    [coder encodeObject:content forKey:@"content"];
    [coder encodeObject:discussedTime forKey:@"discussedTime"];
    [coder encodeObject:activeTime forKey:@"activeTime"];
    [coder encodeObject:achievedTime forKey:@"achievedTime"];
    [coder encodeObject:tailored_goal_id forKey:@"tailored_goal_id"];

    [coder encodeObject:typeOfPacket forKey:@"typeOfPacket"];
    [coder encodeObject:date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [super setTypeOfPacket:[decoder decodeObjectForKey:@"typeOfPacket"]];
        [self setStatus: [decoder decodeObjectForKey:@"status"]];
        [self setContent: [decoder decodeObjectForKey:@"content"]];
        [self setDiscussedTime: [decoder decodeObjectForKey:@"discussedTime"]];
        [self setActiveTime: [decoder decodeObjectForKey:@"activeTime"]];
        [self setAchievedTime: [decoder decodeObjectForKey:@"achievedTime"]];
        [self setTailored_goal_id: [decoder decodeObjectForKey:@"tailored_goal_id"]];

        [super setDate: [decoder decodeObjectForKey:@"date"]];
    }
    return self;
}
@end