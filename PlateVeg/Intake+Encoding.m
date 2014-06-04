//
//  Intake+Encoding.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/1/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Intake+Encoding.h"

@implementation Intake (Encoding)

- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:dairy forKey:@"dairy"];
    [coder encodeObject:fruit forKey:@"fruit"];
    [coder encodeObject:grain forKey:@"grain"];
    [coder encodeObject:legume forKey:@"legume"];
    [coder encodeObject:meat forKey:@"meat"];
    [coder encodeObject:oil forKey:@"oil"];
    [coder encodeObject:sweet forKey:@"sweet"];
    [coder encodeObject:vegetable forKey:@"vegetable"];

    [coder encodeObject:typeOfPacket forKey:@"typeOfPacket"];
    [coder encodeObject:date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [super setTypeOfPacket:[decoder decodeObjectForKey:@"typeOfPacket"]];
//        NSLog(@"DAIRY DECODED %@", [decoder decodeObjectForKey:@"dairy"]);
//        NSLog(@"DAIRY DECODED %@", [decoder decodeObjectForKey:@"type1"]);

        [self setDairy: [decoder decodeObjectForKey:@"dairy"]];
        [self setFruit: [decoder decodeObjectForKey:@"fruit"]];
        [self setGrain: [decoder decodeObjectForKey:@"grain"]];
        [self setLegume: [decoder decodeObjectForKey:@"legume"]];
        [self setMeat: [decoder decodeObjectForKey:@"meat"]];
        [self setOil: [decoder decodeObjectForKey:@"oil"]];
        [self setSweet: [decoder decodeObjectForKey:@"sweet"]];
        [self setVegetable: [decoder decodeObjectForKey:@"vegetable"]];
        [super setDate: [decoder decodeObjectForKey:@"date"]];
    }
    return self;
}

@end
