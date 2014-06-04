//
//  Bcm.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Bcm.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"
@interface Bcm()
@property (nonatomic) NSNumber *weight;
@property (nonatomic) NSString *typeOfPacket;
@property (nonatomic) NSString *date;

@end
@implementation Bcm
@synthesize weight;

-(id) init: (NSNumber *) weight_ : (NSString *) date_ {
    if ( self = [super init] ) {
        super.typeOfPacket = @"BCM";
        weight = weight_;
        super.date = date_;        
    }
    return self;
}

/**
 * FOR JSON Messing
 * */
-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
//    writer.sortKeys = YES;
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:self];
    

    NSString *jsonString = [writer stringWithObject:dict];
//    jsonString = [NSString stringWithFormat:@"{\"date\":\"2013-06-18 11:00:00\",\"typeOfPacket\":\"%@\",\"weight\":%@}", typeOfPacket, [weight stringValue]];
    jsonString = [NSString stringWithFormat:@"{\"date\":\"%@\",\"typeOfPacket\":\"%@\",\"weight\":%@}",
                  date, typeOfPacket, [weight stringValue]];
    
    return jsonString;
}

-(NSString *) string {
    NSString *retString = @"weight: ";
    [retString stringByAppendingString:[[self getWeight] stringValue]];
    [retString stringByAppendingString:@" date: "];
    [retString stringByAppendingString: [super getDate]];
    
    return retString;
}

-(NSNumber *) getWeight{
    return weight;
}

-(void) setWeight:(NSNumber *) weight_ {
    weight = weight_;
}

-(NSDictionary *) getDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}
@end
