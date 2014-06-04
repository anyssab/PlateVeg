//
//  Pdm.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Pdm.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"

@interface Pdm ()
@property (nonatomic) NSNumber *totalSteps;
@property (nonatomic) NSString *typeOfPacket;
@property (nonatomic) NSString *date;
@end

@implementation Pdm
@synthesize totalSteps;

-(id) init: (NSNumber *) totalSteps_ : (NSString *) date_ {
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"PDM"];
        totalSteps = totalSteps_;
        [super setDate:date_];
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
    NSString *retString = @"Steps: ";
    [retString stringByAppendingString:[[self getTotalSteps] stringValue]];
    [retString stringByAppendingString:@" Date: "];
    [retString stringByAppendingString: [super getDate]];
    return retString;
}

-(NSNumber *) getTotalSteps {
    return totalSteps;
}

-(void) setTotalSteps: (NSNumber *) totalSteps_ {
    totalSteps = totalSteps_;
}

-(NSDictionary *) getDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}

@end
