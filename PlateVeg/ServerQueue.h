//
//  ServerQueue.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/23/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server_Client.h"

@protocol ServerQueueDelegate <NSObject>
@required

@optional
- (void)storeIntake: (Intake *) packet;
-(void) storeTracking: (Tracking *) packet;
- (void)storeProgressData: (ProgressData *) progressData;
- (void)storeGoal: (Goal *) packet;
- (void)storeMsg: (Msg *) packet;
- (void)storeTailoredGoal: (TailoredGoal *) packet;
- (void)storeResource: (Resource *) packet;
- (void)recievedUnread: (Unread *) packet;


-(void) msgSuccessfullySent: (NSInteger) msgIndex;
@end

@interface ServerQueue : NSObject <Server_Client_Delegate>
@property (weak, nonatomic) id<ServerQueueDelegate> delegate;
-(void) addToQueue : (Packet *) packet;
@end
