//
//  ProgressData.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 7/18/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "ProgressData.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"

@interface ProgressData ()

@end
@implementation ProgressData
@synthesize data,data2,goal,goal2;


-(id) init: (NSArray *)data_ : (NSArray *)goal_{
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"PROGRESSDATA"];
        goal = goal_;
        data = data_;
    }
    return self;
}


-(id) init: (NSArray *)data_ : (NSArray *)data2_ : (NSArray *)goal_ : (NSArray *)goal2_{
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"PROGRESSDATA"];
        
        data = data_;
        data2 = data2_;
        
        goal = goal_;
        goal2 = goal2_;
        
    }
    return self;
}

-(id) init: (NSDictionary *) dict {
    if (self = [super init]) {
        [super setTypeOfPacket:@"PROGRESSDATA"];
        if ([dict objectForKey:@"data"]) { //only one goal and data
            data = [dict objectForKey:@"data"];
            goal = [dict objectForKey:@"goal"];
        } else {
            data = [[dict objectForKey:@"data2"] objectAtIndex:0];
            goal = [[dict objectForKey:@"goal2"] objectAtIndex:0];
            data2 = [[dict objectForKey:@"data2"] objectAtIndex:1];
            goal2 = [[dict objectForKey:@"goal2"] objectAtIndex:1];
        }

    }
    return self;
}


-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:self];
    NSString *jsonString = [writer stringWithObject:dict];
    return jsonString;
}

@end
