//
//  Goal.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Goal.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"


@interface Goal ()
@property (nonatomic) Intake *intakeGoal;
//@property (nonatomic) NSString *intakeGoal;

@property (nonatomic)NSNumber *pdmGoal;
@property (nonatomic)NSNumber *bcmGoal;
@property (nonatomic)NSNumber *bpmGoal; // Systolic only
@property (nonatomic) NSString *typeOfPacket;
@end

@implementation Goal
@synthesize pdmGoal,bcmGoal,bpmGoal;

-(id) init: (Intake*) intakegoal_ : (NSNumber *) pdmGoal_ :(NSNumber *) bcmGoal_ :(NSNumber *) bpmGoal_ :(NSString *) date_ {
    if ( self = [super init] ) {
        
        [super setTypeOfPacket:@"GOAL"];
        [self setIntakeGoal:intakegoal_];
        [self setPdmGoal:pdmGoal_];
        [self setBcmGoal:bcmGoal_];
        [self setBpmGoal:bpmGoal_];
        [super setDate:date_];
    }
    return self;
}

-(id) init: (NSDictionary *) dict {
    if (self = [super init]) {
        [super setTypeOfPacket:@"INTAKE"];
//        intakeGoal = [dict objectForKey:@"intakeGoal"];
//        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dictRepresentation = [dict objectForKey:@"intakeGoal"];
//        NSLog(@"DICT %@", dictRepresentation);
        intakeGoal = [[Intake alloc] init:dictRepresentation];
//        NSLog(@"%@", [intakeGoal toString]);

//        [self setPdmGoal:[[NSNumber alloc] initWithInt: (int)[dict objectForKey:@"pdmGoal"]]];
//
//        [self setBcmGoal:[[NSNumber alloc] initWithDouble: [[dict objectForKey:@"bcmGoal"]] doublevalue]];
//        [self setBpmGoal:[[NSNumber alloc] initWithInt: [dict objectForKey:@"bpmGoal"]]];
//        [self setBcmGoal:[dict objectForKey:@"bcmGoal"]];
//        [self setBpmGoal:[dict objectForKey:@"bpmGoal"]];
        [super setDate:[dict objectForKey:@"date"]];
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

-(NSString *) string {
    
    NSString *retString = @"IntakeGoal: ";
//    [retString stringByAppendingString:[[self getIntakeGoal] stringValue]];
    [retString stringByAppendingString:@" PDM Goal: "];
    [retString stringByAppendingString: [[self getPdmGoal] stringValue]];
    [retString stringByAppendingString:@" BCM Goal: "];
    [retString stringByAppendingString: [[self getBcmGoal] stringValue]];
    [retString stringByAppendingString:@" BPM Goal: "];
    [retString stringByAppendingString: [[self getBpmGoal] stringValue]];
    [retString stringByAppendingString:@" Date: "];
    [retString stringByAppendingString: [super getDate]];
    return retString;
}

-(Intake*) getIntakeGoal {
    return intakeGoal;
}
-(void) setIntakeGoal:(Intake*) intakeGoal_{
    intakeGoal = intakeGoal_;
}

-(NSNumber *) getPdmGoal {
    return pdmGoal;
}
-(void) setPdmGoal:(NSNumber *) pdmGoal_ {
    pdmGoal = pdmGoal_;
}
-(NSNumber *) getBcmGoal {
    return bcmGoal;
}
-(void) setBcmGoal:(NSNumber *) bcmGoal_ {
    bcmGoal = bcmGoal_;
}
-(NSNumber *) getBpmGoal {
    return bpmGoal;
}
-(void) setBpmGoal:(NSNumber *) bpmGoal_ {
    bpmGoal = bpmGoal_;
}

-(NSDictionary *) getDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}

@end
