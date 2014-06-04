//
//  PlistHandler.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/7/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Msg.h"
#import "TailoredGoal.h"
#import "Resource.h"
#import "Inq.h"


static NSString *const start = @"Start";
static NSString *const walking = @"Walking/Physical Activity";
static NSString *const fruitVeg = @"Fruit & Vegetables";
static NSString *const snacking = @"Snacking";
static NSString *const fastFoods = @"Fast Foods/Eating Out";
static NSString *const drinks = @"Drinks";
static NSString *const meals = @"Meals/Cooking";

@interface PlistHandler : NSObject
-(id) init;
-(void) saveStudyNumber : (NSNumber *) studyNumber;
-(void) savePassword : (NSString *) password;
-(NSNumber *) loadStudyNumber;
-(NSString *) loadPassword;
-(void) clearFile;
-(void) verified;
-(BOOL) isVerified;
-(void) clearPull;
-(NSDate *) loadBCMDate;
-(NSDate *) loadBPMDate;
-(void) saveBCMDate;
-(void) saveBPMDate;
-(void) saveMsgSentAtIndex : (NSInteger) index;
-(void) saveMsgAtIndex: (Msg*)packet :(NSNumber *) index;
-(void) saveMsg: (Msg *) packet sent: (NSNumber *) sent;
-(void) saveMsg: (Msg *) packet;
-(void) saveResource: (Resource *) packet;
-(void) saveTailoredGoal: (TailoredGoal *) packet;
-(void) savePull: (NSDictionary *) packet;
-(NSArray *) loadMsg;
-(NSDictionary *) loadResource;
-(NSDictionary *) loadTailoredGoal;
-(NSArray *) loadPull;

-(Resource *) loadResourceForID: (NSNumber*) resource_id;

-(void) clearMsgs;
-(void) clearTailoredGoals;
-(void) clearResources;
@end
