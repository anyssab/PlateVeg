//
//  Server_Client.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/26/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Packet.h"
#import "Acc.h"
#import "Ack.h"
#import "Bcm.h"
#import "Bpm.h"
#import "Exit.h"
#import "Goal.h"
#import "Inq.h"
#import "Intake.h"
#import "Pdm.h"
#import "ProgressData.h"
#import "Tracking.h"
#import "Msg.h"
#import "Resource.h"
#import "Unread.h"
#import "TailoredGoal.h"
#import "IOSEnrollment.h"

@protocol Server_Client_Delegate <NSObject>
@required
-(void)recievedIntake: (Intake *) packet;
-(void)recievedTracking: (Tracking *) packet;
-(void)recievedGoal: (Goal *) packet;
-(void)recievedProgressData:(ProgressData *) packet;
-(void)recievedMsg:(Msg *) packet;
-(void)recievedResource:(Resource *) packet;
-(void)recievedTailoredGoal:(TailoredGoal *) packet;
-(void)recievedUnread:(Unread *) packet;

-(void) sendNextInQueue;
@end

@interface Server_Client : NSObject<NSStreamDelegate>
@property (weak, nonatomic) id<Server_Client_Delegate> delegate;



- (void)sendAcc: (NSNumber *) stuNum : (NSString *) pass;
- (void)sendBcm: (NSNumber *) weight : (NSString *) date;
- (void)sendBcm: (Bcm *) bcm;
- (void)sendBpm: (Bpm *) bpm;
- (void)sendBpm:(NSNumber *) systolic : (NSNumber *) diastolic :(NSNumber *) map :(NSNumber *) pulse :(NSString *) date;
- (void)sendExit;
- (void)sendIOSEnrollment: (NSString *) device_id;
- (void) sendInq: (Inq *) inq;
//- (void)sendInqUnread: (NSString*)requestType;
//- (void)sendInqIntake : (NSDate*) givenDate;
//- (void)sendInqGoal: (NSNumber *) weight : (NSNumber *) height : (NSNumber *) age : (NSNumber *) gender : (NSNumber *) maintainWeight;
//- (void)sendInqTracking: (NSString *) ttype;
//- (void)sendInqProgressData: (NSString*)requestType : (NSUInteger) period;
- (void) sendIntake: (Intake *) intake;
- (void)sendIntake: (NSNumber *) num1 : (NSNumber *) num2 :(NSNumber *) num3 :(NSNumber *) num4 :(NSNumber *) num5 :
(NSNumber *) num6 :(NSNumber *) num7 :(NSNumber *) num8 : (NSDate *) date;
- (void) sendMsg: (Msg *) msg;
- (void) sendMsg: (NSNumber *) from : (NSNumber *) to :  (NSString *) text :  (NSNumber *) resourceID;
- (void) openSocket;
- (void) closeSocket;

- (BOOL) inputStreamReady;
- (BOOL) outputStreamReady;
@end
