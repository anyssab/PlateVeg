//
//  IntakeObject.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 7/30/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Intake.h"

@interface IntakeObject : NSObject
@property (nonatomic) Intake *value;
@property (nonatomic) NSDate *date;
@property (nonatomic) BOOL sent;

-(id) init;
-(id) initWithData: (Intake *) value_ : (NSDate *) date_;

@end

