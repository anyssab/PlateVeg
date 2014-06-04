//
//  Intake.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Intake.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"

@interface Intake ()
@property (nonatomic) NSNumber *dairy;
@property (nonatomic) NSNumber *fruit;
@property (nonatomic) NSNumber *grain;
@property (nonatomic) NSNumber *legume;
@property (nonatomic) NSNumber *meat;
@property (nonatomic) NSNumber *oil;
@property (nonatomic) NSNumber *sweet;
@property (nonatomic) NSNumber *vegetable;
@property (nonatomic) NSString *typeOfPacket;
@property (nonatomic) NSString *date;


@end

@implementation Intake
@synthesize dairy,fruit,grain,legume,meat,oil,sweet,vegetable;


-(id) init: (NSNumber *) type1_ : (NSNumber *) type2_ : (NSNumber *) type3_ : (NSNumber *) type4_ : (NSNumber *) type5_ : (NSNumber *) type6_ : (NSNumber *) type7_ : (NSNumber *) type8_ : (NSString *) date_ {
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"INTAKE"];
        [self setDairy: type1_];
        [self setFruit: type2_];
        [self setGrain: type3_];
        [self setLegume: type4_];
        [self setMeat: type5_];
        [self setOil: type6_];
        [self setSweet: type7_];
        [self setVegetable: type8_];
        [super setDate:date_];

    }
    return self;
}

-(id) init: (NSDictionary *) dict {
    if (self = [super init]) {
        [super setTypeOfPacket:@"INTAKE"];
        [self setDairy: [dict objectForKey:@"dairy"]];
        [self setFruit: [dict objectForKey:@"fruit"]];
        [self setGrain: [dict objectForKey:@"grain"]];
        [self setLegume: [dict objectForKey:@"legume"]];
        [self setMeat: [dict objectForKey:@"meat"]];
        [self setOil: [dict objectForKey:@"oil"]];
        [self setSweet: [dict objectForKey:@"sweet"]];
        [self setVegetable: [dict objectForKey:@"vegetable"]];
        [super setDate: [dict objectForKey:@"date"]];
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

-(NSArray *) toArray{
    NSArray* array = [NSArray arrayWithObjects:
                      @"dairy", dairy,
                      @"fruit", fruit,
                      @"grain", grain,
                      @"legume", legume,
                      @"meat", meat,
                      @"oil", oil,
                      @"sweet", sweet,
                      @"vegetable", vegetable,
                      @"typeOfPacket", typeOfPacket,
                      @"date", date,
                      nil];
    return array;
}

//-(NSString *) string {
//    NSString *retString = @"Type1: ";
//    [retString stringByAppendingString:[[self getType1] stringValue]];
//    [retString stringByAppendingString:@" Type2: "];
//    [retString stringByAppendingString: [[self getType2] stringValue]];
//    [retString stringByAppendingString:@" Type3: "];
//    [retString stringByAppendingString: [[self getType3] stringValue]];
//    [retString stringByAppendingString:@" Type4: "];
//    [retString stringByAppendingString: [[self getType4] stringValue]];
//    [retString stringByAppendingString:@" Type5: "];
//    [retString stringByAppendingString: [[self getType5] stringValue]];
//    [retString stringByAppendingString:@" Type6: "];
//    [retString stringByAppendingString: [[self getType6] stringValue]];
//    [retString stringByAppendingString:@" Type7: "];
//    [retString stringByAppendingString: [[self getType7] stringValue]];
//    [retString stringByAppendingString:@" Type8: "];
//    [retString stringByAppendingString: [[self getType8] stringValue]];
//    [retString stringByAppendingString:@" Date: "];
//    [retString stringByAppendingString: [super getDate]];
//    return retString;
//}


-(NSNumber *) getDairy {
    return dairy;
}
-(void) setDairy:(NSNumber *)dairy_ {
    dairy = dairy_;
}
-(NSNumber *) getFruit {
    return fruit;
}
-(void) setFruit:(NSNumber *)fruit_ {
    fruit = fruit_;
}
-(NSNumber *) getGrain {
    return grain;
}
-(void) setGrain:(NSNumber *)grain_ {
    grain = grain_;
}
-(NSNumber *) getLegume {
    return legume;
}
-(void) setLegume:(NSNumber *)legume_ {
    legume = legume_;
}
-(NSNumber *) getMeat {
    return meat;
}
-(void) setMeat:(NSNumber *)meat_ {
    meat = meat_;
}
-(NSNumber *) getOil {
    return oil;
}
-(void) setOil:(NSNumber *)oil_ {
    oil = oil_;
}
-(NSNumber *) getSweet {
    return sweet;
}
-(void) setSweet:(NSNumber *)sweet_ {
    sweet = sweet_;
}
-(NSNumber *) getVegetable {
    return vegetable;
}
-(void) setVegetable:(NSNumber *)vegetable_ {
    vegetable = vegetable_;
}

-(NSDictionary *) getDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}


@end
