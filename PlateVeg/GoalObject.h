//
//  GoalObject.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/1/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Intake.h"

@interface GoalObject : NSObject <NSCoding>
@property (nonatomic) Intake *value;
@property (nonatomic) NSDate *date;

-(id) init;
-(id) initWithData: (Intake *) value_ : (NSDate *) date_;
@end
