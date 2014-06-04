//
//  Bpm.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Bpm.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"


@interface Bpm()
@property (nonatomic) NSNumber *systolic;
@property (nonatomic) NSNumber *diastolic;
@property (nonatomic) NSNumber *map;
@property (nonatomic) NSNumber *pulse;
@property (nonatomic) NSString *typeOfPacket;
@property (nonatomic) NSString *date;



@end

@implementation Bpm
@synthesize systolic,diastolic,map,pulse;


-(id) init: (NSNumber *) systolic_ : (NSNumber *) diastolic_ :(NSNumber *) map_ :(NSNumber *) pulse_ :(NSString *) date_ {
    if ( self = [super init] ) {
        super.typeOfPacket = @"BPM";
        [self setSystolic:systolic_];
        [self setDiastolic:diastolic_];
        [self setMap:map_];
        [self setPulse:pulse_];
        
        super.date = date_;
    }
    return self;
}


/**
 * FOR JSON Messing
 * */
-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary* dict = [NSDictionary dictionaryWithPropertiesOfObject:self];
    NSString *jsonString = [writer stringWithObject:dict];
    return jsonString;
}


-(NSString *) string{
    NSString *retString = @"Systolic: ";
    [retString stringByAppendingString:[[self getDiastolic] stringValue]];
    [retString stringByAppendingString:@" Diastolic: "];
    [retString stringByAppendingString: [[self getDiastolic] stringValue]];
    [retString stringByAppendingString:@" MAP: "];
    [retString stringByAppendingString: [[self getMap] stringValue]];
    [retString stringByAppendingString:@" Date: "];
    [retString stringByAppendingString: [super getDate]];
    return retString;
}



-(NSNumber *) getSystolic {
    return systolic;
}

-(void) setSystolic: (NSNumber *)systolic_ {
    systolic = systolic_;
}
-(NSNumber *) getDiastolic {
    return diastolic;
}

-(void) setDiastolic:(NSNumber *) diastolic_{
    diastolic = diastolic_;
}

-(NSNumber *) getMap {
    return map;
}

-(void) setMap: (NSNumber *)map_ {
    map = map_;
}

-(NSNumber *) getPulse {
    return pulse;
}

-(void) setPulse: (NSNumber *) pulse_ {
    pulse = pulse_;
}

-(NSDictionary *) getDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}
@end
