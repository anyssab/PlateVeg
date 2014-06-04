//
//  Server_Client.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/26/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//
#import "Server_Client.h"

#import "NSDate+DateMethods.h"

//#define TIMES_TRIED_TO_CONNECT_LIMIT 20

@interface Server_Client ()
@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;
@property (nonatomic) NSInteger timesTriedToConnect;
@property (atomic) BOOL inputStreamOpen;
@property (atomic) BOOL outputStreamOpen;
@end

@implementation Server_Client
@synthesize inputStream, outputStream;
@synthesize inputStreamOpen, outputStreamOpen;

@synthesize timesTriedToConnect;

-(id) init {
    if(self = [super init] ) {
        timesTriedToConnect = 0;
        inputStreamOpen = NO;
        outputStreamOpen = NO;
    }
    return self;
}

- (void) openSocket {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSData *iosTrustedCertDerData =
    [NSData dataWithContentsOfFile:[bundle pathForResource:@"selfsigned"
                                                    ofType:@"cer"]];
    SecCertificateRef certificate =
    SecCertificateCreateWithData(NULL,
                                 (__bridge CFDataRef) iosTrustedCertDerData);
    [self useKeychain:certificate];
    
}

- (void) useKeychain: (SecCertificateRef) certificate {
    OSStatus err =
    SecItemAdd((__bridge CFDictionaryRef) [NSDictionary dictionaryWithObjectsAndKeys:
                                           (__bridge id) kSecClassCertificate, kSecClass,
                                           certificate, kSecValueRef,
                                           nil],
               NULL);
    if ((err == noErr) || // success!
        (err == errSecDuplicateItem)) { // the cert was already added.  Success!
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        CFStreamCreatePairWithSocketToHost(NULL,
                                           (CFStringRef)@"dashmobile.bumc.bu.edu",
                                           55556,
                                           &readStream,
                                           &writeStream);
        
        /* Turning on this setting makes the SSL handshake fail with OSStatus -9807 */
        CFReadStreamSetProperty(readStream,
                                kCFStreamPropertySocketSecurityLevel,
                                kCFStreamSocketSecurityLevelTLSv1);
        
        NSDictionary *sslSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                     (id)kCFBooleanFalse, (id)kCFStreamSSLValidatesCertificateChain,
                                     nil];
        CFReadStreamSetProperty(readStream,
                                kCFStreamPropertySSLSettings,
                                (__bridge CFTypeRef)(sslSettings));
        self.inputStream = (__bridge NSInputStream *)readStream;
        self.outputStream = (__bridge NSOutputStream *)writeStream;
        [self.inputStream setDelegate:self];
        [self.outputStream setDelegate:self];
        [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                    forMode:NSDefaultRunLoopMode];
        [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                     forMode:NSDefaultRunLoopMode];
        CFReadStreamOpen(readStream);
        CFWriteStreamOpen(writeStream);
    } else {
        // handle the error.  There is probably something wrong with your cert.
        NSLog(@"ERROR IN CERT");
    }
}

-(void) encode: (Packet *) message {
    Packet *packet = (Packet *) message;
    NSString *json = [packet toString];
    
	NSData *data = [[NSData alloc] initWithData:[json dataUsingEncoding:NSASCIIStringEncoding]];
    NSUInteger type;
    
    if ([[packet getTypeOfPacket] isEqualToString:@"EXIT"]) {
        type = 0;
    } else if ([[packet getTypeOfPacket] isEqualToString:@"ACK"]) {
        type = 1;
    } else if ([[packet getTypeOfPacket] isEqualToString:@"ACC"]) {
        type = 2;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"PDM"]) {
        type = 3;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"BCM"]) {
        type = 4;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"BPM"]) {
        type = 5;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"INTAKE"]) {
        type = 6;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"TRACKING"]) {
        type = 7;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"GOAL"]) {
        type = 8;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"INQ"]) {
        type = 9;
    } else if ([[packet getTypeOfPacket] isEqualToString:@"PROGRESSDATA"]) {
        type = 10;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"GCM"]) {
        type = 11;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"Resource"]) {
        type = 12;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"TailoredGoal"]) {
        type = 13;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"Msg"]) {
        type = 14;
    }else if ([[packet getTypeOfPacket] isEqualToString:@"IOSENROLLMENT"]) {
        type = 15;
    } else {
        NSLog(@"Error: NO Type");
        type = -1;
    }
    uint32_t packet_length = CFSwapInt32HostToBig([data length]);
    uint32_t packet_type = CFSwapInt32HostToBig(type);
    
    NSLog(@"Sending: %@", json);
    [outputStream write:(uint8_t*)&packet_length maxLength:sizeof(NSUInteger)];
    [outputStream write:(uint8_t*)&packet_type maxLength:sizeof(NSUInteger)];
    [outputStream write:[data bytes] maxLength:[data length]];
}

- (void)sendAcc: (NSNumber *) stuNum : (NSString *) pass{
    Packet *packet;
    Acc *acc = [[Acc alloc] init:stuNum : pass];
    packet = (Packet *) acc;
    [self encode:packet];
}
- (void)sendBcm: (NSNumber *) weight : (NSString *) date {
    Packet *packet;
    Bcm *bcm = [[Bcm alloc] init:weight :date];
    packet = (Packet *) bcm;
    [self encode:packet];
}

- (void)sendBcm: (Bcm *) bcm{
    Packet *packet;
    packet = (Packet *) bcm;
    [self encode:packet];
}
- (void)sendBpm: (Bpm *) bpm{
    Packet *packet;
    packet = (Packet *) bpm;
    [self encode:packet];
}

- (void)sendBpm:(NSNumber *) systolic : (NSNumber *) diastolic :(NSNumber *) map :(NSNumber *) pulse :(NSString *) date {
    Packet *packet;
    Bpm *bcm = [[Bpm alloc] init:systolic :diastolic :map :pulse :date];
    packet = (Packet *) bcm;
    [self encode:packet];
}
- (void)sendExit{
    Packet *packet;
    Exit *exit = [[Exit alloc] init];
    packet = (Packet *) exit;
    [self encode:packet];
}

- (void)sendIOSEnrollment: (NSString *) device_id{
    Packet *packet;
    IOSEnrollment *enroll = [[IOSEnrollment alloc] init:device_id];
    packet = (Packet *) enroll;
    [self encode:packet];
}

- (void)sendInqIntake : (NSDate*) givenDate{
    Packet *packet;
    NSString *type = @"INTAKE";
    NSString *date = [NSDate getDateString: givenDate];
    Inq *inq = [[Inq alloc] initIntake:type :date];
    packet = (Packet *) inq;
    [self encode:packet];
}

- (void)sendInqGoal: (NSNumber *) weight : (NSNumber *) height : (NSNumber *) age : (NSNumber *) gender : (NSNumber *) maintainWeight {
    Packet *packet;
    NSString *type = @"GOAL";
    Inq *inq = [[Inq alloc] initGoal:type :weight :height :age :gender :maintainWeight];
    packet = (Packet *) inq;
    [self encode:packet];
}


- (void)sendInqTracking: (NSString *) ttype{
    Packet *packet;
    NSString *type = @"TRACKING";
    Inq *inq = [[Inq alloc] initTracking:type : ttype];
    
    packet = (Packet *) inq;
    [self encode:packet];
}

- (void)sendInqProgressData: (NSString*)requestType : (NSUInteger) period{
    Packet *packet;
    NSString *type = @"PROGRESSDATA";
    Inq *inq = [[Inq alloc] initProgressData:type :requestType :period];
    packet = (Packet *) inq;
    [self encode:packet];
}

//- (void)sendInqPull: (NSNumber){
//    Packet *packet;
//    NSString *type = @"PULL";
//    Inq *inq = [[Inq alloc] initProgressData:type :requestType :period];
//    packet = (Packet *) inq;
//    [self encode:packet];
//}

-(void) sendIntake: (Intake *) intake {
    Packet *packet;
    packet = (Packet *) intake;
    [self encode:packet];
}

-(void) sendInq: (Inq *) inq {
    Packet *packet;
    packet = (Packet *) inq;
    [self encode:packet];
}
//- (void)sendInqUnread: (NSString*)requestType{
//    Packet *packet;
//    NSString *type = @"Unread";
//    Inq *inq = [[Inq alloc] initUnread:type :requestType];
//    
//    packet = (Packet *) inq;
//    [self encode:packet];
//}
- (void)sendIntake: (NSNumber *) num1 : (NSNumber *) num2 :(NSNumber *) num3 :(NSNumber *) num4 :(NSNumber *) num5 :
(NSNumber *) num6 :(NSNumber *) num7 :(NSNumber *) num8 : (NSDate *) date{
    Packet *packet;
    Intake *intake = [[Intake alloc] init:num1 :num2 :num3 :num4 :num5 :num6 :num7 :num8 :[NSDate getDateString:date]];
    
    packet = (Packet *) intake;
    [self encode:packet];
}
-(void) sendMsg: (Msg *) msg {
    Packet *packet;
    packet = (Packet *) msg;
    [self encode:packet];
}
-(void) sendMsg: (NSNumber *) from : (NSNumber *) to :  (NSString *) text :  (NSNumber *) resourceID{
    Packet *packet;
    Msg *msg = [[Msg alloc] init:from :to :text :resourceID];
    
    packet = (Packet *) msg;
    [self encode:packet];
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    switch (streamEvent) {
        case NSStreamEventOpenCompleted:
        {
            if ([theStream isKindOfClass:[NSInputStream class]]) {
                NSLog(@"Input Stream: OPENED");
                inputStreamOpen = YES;
            } else if ([theStream isKindOfClass:[NSOutputStream class]]) {
                NSLog(@"Output Stream: OPENED");
                outputStreamOpen = YES;
            }
        }
            break;
        case NSStreamEventHasBytesAvailable:
            if (theStream == inputStream) {
                uint8_t buffer[1024];
                int len;
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        NSInteger length = (buffer[0] << 24) + (buffer[1] << 16) + (buffer[2] << 8) + (buffer[3]);
                        NSInteger type = (buffer[4] << 24) + (buffer[5] << 16) + (buffer[6] << 8) + (buffer[7]);
                        uint8_t packet_buf[length];
                        memcpy(packet_buf, buffer+8,len);
                        NSString *packetContents = [[NSString alloc] initWithBytes:packet_buf
                                                                            length:length
                                                                          encoding:NSUTF8StringEncoding];
                        NSLog(@"Recieved: %@",packetContents);
                        SBJsonParser *parser = [[SBJsonParser alloc] init];
                        Packet *packet;
                        NSDictionary *dictRepresentation;
                        if (type == 1) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *)[[Ack alloc] init:dictRepresentation];
                            if([[(Ack *) packet getOpCode] isEqualToString:@"VALID"]) {
                                NSLog(@"Packet: VALID");
                            } else if([[(Ack *) packet getOpCode] isEqualToString:@"FAILED"] ) {
                                NSLog(@"Packet: FAILED");
                            } else {
                                NSLog(@"Packet: UPDATED");
                            }
                        } else if (type == 6) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *) [[Intake alloc] init:dictRepresentation];
                            [self.delegate recievedIntake: (Intake *) packet];
                        } else if (type == 7) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *) [[Tracking alloc] init:dictRepresentation];
                            [self.delegate recievedTracking: (Tracking *) packet];
                        } else if (type == 8) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *) [[Goal alloc] init:dictRepresentation];
                            [self.delegate recievedGoal: (Goal *) packet];
                        } else if (type == 10) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *) [[ProgressData alloc] init:dictRepresentation];
                            [self.delegate recievedProgressData:(ProgressData *) packet];
                        } else if (type == 12) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *) [[Resource alloc] init:dictRepresentation];
                            [self.delegate recievedResource:(Resource *) packet];
                        } else if (type == 10) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *) [[ProgressData alloc] init:dictRepresentation];
                            [self.delegate recievedProgressData:(ProgressData *) packet];
                        } else if (type == 13) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *) [[TailoredGoal alloc] init:dictRepresentation];
                            [self.delegate recievedTailoredGoal:(TailoredGoal *) packet];
                        } else if (type == 14) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *) [[Msg alloc] init:dictRepresentation];
                            [self.delegate recievedMsg:(Msg *) packet];
                        }else if (type == 16) {
                            dictRepresentation = [parser objectWithString:packetContents];
                            packet = (Packet *) [[Unread alloc] init:dictRepresentation];
                            [self.delegate recievedUnread:(Unread *) packet];
                        } else {
                            NSLog(@"Error: Type Unknown: %d", type);
                            type = -1;
                        }
                        if (packet != nil){
                            [self.delegate sendNextInQueue];
                        }
                    }
                    
                }
            }
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
        case NSStreamEventEndEncountered:
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            NSLog(@"Stream closed");
            theStream = nil;
            break;
        default:
            break;
    }
    
}

-(BOOL) inputStreamReady {
    return inputStreamOpen;
}

-(BOOL) outputStreamReady {
    return outputStreamOpen;
}

-(void) closeSocket {
    [self.inputStream close];
    [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    NSLog(@"Input Stream: CLOSED");
    inputStreamOpen = NO;
    self.inputStream = nil;
    
    [self.outputStream close];
    [self.outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    NSLog(@"Output Stream: CLOSED");
    outputStreamOpen = NO;
    self.outputStream = nil;
}



@end
