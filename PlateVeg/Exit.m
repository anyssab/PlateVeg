//
//  Exit.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Exit.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"

@interface Exit ()
@property (nonatomic) NSNumber *returnVal;
@property (nonatomic) NSString *typeOfPacket;
@end
@implementation Exit
@synthesize returnVal;

-(id) init {
    if ( self = [super init] ) {
        super.typeOfPacket = @"EXIT";
        returnVal = [[NSNumber alloc] initWithInt:0];
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
//    NSLog(@"%@", jsonString);
    return jsonString;
}

-(NSDictionary *) getDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}

-(NSNumber *) getReturnVal {
    return returnVal;
}

-(void) setReturnVal: (NSNumber *) returnVal_ {
    returnVal = returnVal_;
}



@end
