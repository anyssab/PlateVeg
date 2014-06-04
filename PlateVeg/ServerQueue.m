//
//  ServerQueue.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/23/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "ServerQueue.h"
#import "PlistHandler.h"
#import "AppDelegate.h"
#import "MsgObject.h"

@interface ServerQueue ()
@property (nonatomic, strong) NSMutableArray *queue;
@property (nonatomic, strong) Server_Client *client;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSNumber *studyNumber;
@property (nonatomic) BOOL sentAcc;

@property (atomic) BOOL queueRunning;
@property (atomic) NSInteger numAck;
@property (atomic) NSInteger msgIndexNum;


@end

@implementation ServerQueue
@synthesize queue, client;
@synthesize password, studyNumber, sentAcc, queueRunning;
@synthesize numAck, msgIndexNum;

-(id) init {
    if (self = [super init]) {
        queue = [[NSMutableArray alloc] init];
        client = [[Server_Client alloc] init];
        client.delegate = self;
        PlistHandler *handler = [[PlistHandler alloc] init];
        password = [handler loadPassword];
        studyNumber = [handler loadStudyNumber];
        sentAcc = NO;
        queueRunning = NO;
        numAck = 0;
        msgIndexNum = 0;
    }
    return self;
}


//loop until socket is ready
-(void) tryToStartQueue {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if ([client inputStreamReady] && [client outputStreamReady]) {
        [self sendNextInQueue];
    } else {
        [self performSelector:@selector(tryToStartQueue) withObject:nil afterDelay:0.1];
    }
}
-(void) addToQueue : (Packet *) packet {
    [queue addObject:packet];
    if (!queueRunning) { 
        queueRunning = YES;
        [client openSocket];
        [self tryToStartQueue];
    }
}

-(Packet *) dequeue {
    if ([queue count] > 0) {

        Packet *packet = [queue objectAtIndex:0];
        [queue removeObjectAtIndex:0];
        
        if ([packet isKindOfClass:[MsgObject class]]) {
            msgIndexNum = [[((MsgObject *)packet) msgIndex] integerValue];
            packet = [((MsgObject *)packet) value];
        }
        
        return packet;
    } else {
        NSLog(@"END OF QUEUE");
        return nil;
    }
}

-(void) sendNextInQueue {
    if (sentAcc == NO) {
        [client sendAcc:studyNumber :password];
        sentAcc = YES;
    } else {
        numAck++;
//        if (numAck > 1 && [self.delegate isKindOfClass:[CommunicationViewController class]]) {
//            [self.delegate msgSuccessfullySent:msgIndexNum];
//            
//        }
        Packet *packet = [self dequeue];
        if (packet == nil) {
            [self endOfQueue];
        } else if ([packet isKindOfClass:[Inq class]]) { //Inq most frequent
            [client sendInq:(Inq *) packet];
        } else if ([packet isKindOfClass:[Bcm class]]) {
            [client sendBcm:(Bcm *) packet];
        } else if ([packet isKindOfClass:[Bpm class]]) {
            [client sendBpm:(Bpm *) packet];
        } else if ([packet isKindOfClass:[Msg class]]) {
            [client sendMsg:(Msg *) packet];
        } else if ([packet isKindOfClass:[Intake class]]) {
            [client sendIntake:(Intake *) packet];
        }

    }
    
}

-(void) endOfQueue {
    [client sendExit];
    [client closeSocket];
    numAck = 0;
    queueRunning = NO;
    sentAcc = NO;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}



//Server client delegate methods
-(void)recievedIntake: (Intake *) packet{
    [self.delegate storeIntake:packet];
}
-(void)recievedTracking: (Tracking *) packet{
    [self.delegate storeTracking:packet];
}
-(void)recievedGoal: (Goal *) packet{
    [self.delegate storeGoal:packet];
}
-(void)recievedProgressData:(ProgressData *) packet{
    [self.delegate storeProgressData:packet];
}

-(void)recievedMsg:(Msg *) packet{
    [self.delegate storeMsg:packet];
}
-(void)recievedTailoredGoal:(TailoredGoal *) packet{
    [self.delegate storeTailoredGoal:packet];
}
-(void)recievedResource:(Resource *) packet{
    [self.delegate storeResource:packet];
}
-(void)recievedUnread:(Unread *)packet {
    [self.delegate recievedUnread:packet];

}

@end
