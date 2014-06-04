//
//  Tracking.m
//  Test
//
//  Created by Ross Tang Him on 6/10/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Tracking.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"

@interface Tracking()
@property (nonatomic) NSNumber *_BP;
@property (nonatomic) NSNumber *_Steps;
@property (nonatomic) NSNumber *_Intake;
@property (nonatomic) NSNumber *_Weight;
@property (nonatomic) NSString *type;

//@property (nonatomic) TrackingType *_type;
@property (nonatomic) NSString *typeOfPacket;
@end

@implementation Tracking
@synthesize _BP,_Steps,_Intake,_Weight,type;
-(id) init: (NSNumber *) BP : (NSNumber *) steps :  (NSNumber *) intake :  (NSNumber *) weight :  (NSString *) type_ {
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"TRACKING"];
        _BP = BP;
        _Steps = steps;
        _Intake = intake;
        _Weight = weight;
        type = type_;
    }
    return self;
}

-(id) init: (NSDictionary *) dict {
    if (self = [super init]) {
        [super setTypeOfPacket:@"TRACKING"];
        _BP = [dict objectForKey:@"_BP"];
        _Steps = [dict objectForKey:@"_Steps"];
        _Intake = [dict objectForKey:@"_Intake"];
        _Weight = [dict objectForKey:@"_Weight"];
        type = [dict objectForKey:@"type"];

    }
    return self;
}


-(NSString *) string {
    NSString *retString = @"BP: ";
    [retString stringByAppendingString:[[self get_BP] stringValue]];
    [retString stringByAppendingString:@" Steps: "];
    [retString stringByAppendingString: [[self get_Steps] stringValue]];
    [retString stringByAppendingString:@" Intake: "];
    [retString stringByAppendingString: [[self get_Intake] stringValue]];
    [retString stringByAppendingString:@" Weight: "];
    [retString stringByAppendingString: [[self get_Weight] stringValue]];
    return retString;
}

-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:self];
    NSString *jsonString = [writer stringWithObject:dict];
    return jsonString;
}


-(NSNumber *) get_BP {
    return _BP;
}
-(void) set_BP:(NSNumber *) _BP_ {
    self._BP = _BP_;
}
-(NSNumber *) get_Steps {
    return _Steps;
}
-(void) set_Steps:(NSNumber *) _Steps_ {
    self._Steps = _Steps_;
}
-(NSNumber *) get_Intake {
    return _Intake;
}
-(void) set_Intake: (NSNumber *) _Intake_ {
    self._Intake = _Intake_;
}
-(NSNumber *) get_Weight {
    return _Weight;
}
-(void) set_Weight:(NSNumber *) _Weight_ {
    self._Weight = _Weight_;
}
-(NSString *) getType {
    return type;
}
-(void) setType:(NSString *) type_ {
    self.type = type_;
}
@end
