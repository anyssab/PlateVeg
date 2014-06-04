//
//  Inq.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Inq.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"

@interface Inq ()
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *typeOfPacket;
@property (nonatomic) NSString *date;

// OPTIONAL. ONLY needed for TRACKING
@property (nonatomic) NSString *ttype;

//OPTIONAL. ONLY needed for PROGRESSDATA
@property (nonatomic) NSString *requestType;
@property (nonatomic) NSUInteger period;


// OPTIONAL. ONLY needed for GOAL.
@property (nonatomic) NSNumber *weight;
@property (nonatomic) NSNumber *height;
@property (nonatomic) NSNumber *age;
@property (nonatomic) NSNumber *gender;
@property (nonatomic) NSNumber *maintainWeight;


// OPTIONAL. ONLY needed for GOAL.
@property (nonatomic) NSNumber *pull_id;
// EOF OPTIONAL
@end

@implementation Inq
@synthesize type,ttype,requestType,period,weight,height,age,gender,maintainWeight,pull_id;




-(id) init: (NSString *) type_ {
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"INQ"];
        type = type_;
    }
    return self;
}

-(id) initIntake: (NSString *) type_ : (NSString *) date_{
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"INQ"];
        type = type_;
        date = date_;
    }
    return self;
}


-(id) initTracking: (NSString *) type_ : (NSString *) ttype_{
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"INQ"];
        self.type = type_;
        self.ttype = ttype_;
//        NSLog(@"TTYPE %@", ttype_);
    }
    return self;
}

//check maintainweight
-(id) initGoal: (NSString *) type_ : (NSNumber *) weight_ : (NSNumber *) height_ : (NSNumber *) age_ : (NSNumber *) gender_ : (NSNumber *) maintainWeight_{
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"INQ"];
        self.type = type_;
        self.weight = weight_;
        self.height = height_;
        self.age = age_;
        self.gender = gender_;
        self.maintainWeight = maintainWeight_;
    }
    return self;
}

-(id) initProgressData: (NSString *) type_ : (NSString *) requestType_ : (NSUInteger) period_{
    if (self = [super init] ) {
        [super setTypeOfPacket:@"INQ"];
        self.type = type_;
        self.requestType = requestType_;

        self.period = period_;
    }
    return self;
}

-(id) initUnread: (NSString *) type_ : (NSString *) requestType_{
    if (self = [super init] ) {
        [super setTypeOfPacket:@"INQ"];
        self.type = type_;
        self.requestType = requestType_;
    }
    return self;
}


-(id) initPull: (NSString *) type_ : (NSString *) requestType_ : (NSNumber *) pull_id_{
    if (self = [super init] ) {
        [super setTypeOfPacket:@"INQ"];
        self.type = type_;
        self.requestType = requestType_;
        self.pull_id = pull_id_;
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


-(NSNumber *) getPull_id {
    return pull_id;
}

-(void) setPull_id:(NSNumber *)pull_id_{
    pull_id = pull_id_;
}
-(NSString *) getType {
    return type;
}
-(void) setType: (NSString *) type_ {
    type = type_;
}
-(NSNumber *) getWeight {
    return weight;
}

-(void) setWeight:(NSNumber *)weight_ {
    weight = weight_;
}

-(NSNumber *)getHeight {
    return height;
}

-(void) setHeight:(NSNumber *) height_ {
    height = height_;
}

-(NSNumber *) getAge {
    return age;
}

-(void) setAge: (NSNumber *)age_ {
    age = age_;
}

-(NSNumber *) getGender {
    return gender;
}

-(void) setGender: (NSNumber *) gender_ {
    gender = gender_;
}

-(void) setMaintainWeight:(NSNumber *)maintainWeight_ {
    maintainWeight = maintainWeight_;
}
-(NSNumber *) getMaintainWeight {
    return maintainWeight;
}


@end

