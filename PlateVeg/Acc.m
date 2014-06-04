//
//  Acc.m
//  Dash Server Client
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Acc.h"
#import "SBJson.h"
#import "NSDictionary(dictionaryWithObject).h"

@interface Acc ()
@property (nonatomic, retain) NSNumber *studyNumber;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *typeOfPacket;

@end

@implementation Acc
@synthesize studyNumber,password;


-(id) init: (NSNumber *) studyNumber_ :(NSString *) password_ {
    if (self = [super init] ) {
        super.typeOfPacket = @"ACC";
        self.studyNumber = studyNumber_;
        self.password = password_;
    }
    return self;
}

/**
 * FOR JSON Messing
 * */
-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    writer.sortKeys = YES;

    NSDictionary *dict = [[NSDictionary alloc] init];
    dict = [NSDictionary dictionaryWithPropertiesOfObject:self];

    NSString *jsonString = [writer stringWithObject:dict];
    return jsonString;
}

-(NSDictionary *) getDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}

-(NSString *) getPassword {
    return password;
}

-(NSNumber *) getStudyNumber {
    return studyNumber;
}

@end

