//
//  PlistHandler.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/7/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "PlistHandler.h"
#import "MsgObject.h"
#import "Inq.h"

@interface PlistHandler ()
@property (nonatomic, retain) NSString *path;
@property (nonatomic) NSMutableData *dataObject;
@property (nonatomic) NSKeyedArchiver *archiver;
@property (nonatomic) NSKeyedUnarchiver *unarchiver;
@end

@implementation PlistHandler
@synthesize path;

-(id) init {
    if (self = [super init]) {
        [self getFile];
    }
    return self;
}

-(void) clearFile {
    NSDictionary *originalPlist = nil;
    [originalPlist writeToFile:path atomically:YES];
}
//Just load the file
-(void) getFile {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"UserData.plist"];
//    NSLog(@"PATH HANDLER %@", path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
}

-(NSDate *) loadBCMDate {
    NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSDate *date = [savedData objectForKey:@"BCMDate"];
    
    if (!date) {
        NSLog(@"ERROR, no BCM date stored");
    }
    return date;
}

-(NSDate *) loadBPMDate {
    NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSDate *date = [savedData objectForKey:@"BPMDate"];
    
    if (!date) {
        NSLog(@"ERROR, no BPM date stored");
    }
    return date;
}

-(void) saveBCMDate {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSDate *date = [NSDate date];
    [data setObject:date forKey:@"BCMDate"];
    [data writeToFile: path atomically:YES];
    NSLog(@"SAVED BCM DATE");
}

-(void) saveBPMDate {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSDate *date = [NSDate date];
    [data setObject:date forKey:@"BPMDate"];
    [data writeToFile: path atomically:YES];
    NSLog(@"SAVED BPM DATE");

}

-(void) saveStudyNumber : (NSNumber *) studyNumber{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [data setObject:studyNumber forKey:@"StudyNumber"];
    [data writeToFile: path atomically:YES];
}

-(void) savePassword : (NSString *) password{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [data setObject:password forKey:@"Password"];
    [data writeToFile: path atomically:YES];
}

-(NSNumber *) loadStudyNumber {
    NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSNumber *studyNumber = [savedData objectForKey:@"StudyNumber"];
    
    if (!studyNumber) {
        NSLog(@"ERROR, no study number stored");
    }
    return studyNumber;
}

-(NSString *) loadPassword {
    NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSString *password = [savedData objectForKey:@"Password"];
    
    if (!password) {
        NSLog(@"ERROR, no password stored");
    }
    return password;
}

-(void) verified {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [data setObject:[NSNumber numberWithBool:YES] forKey:@"verified"];
    [data writeToFile: path atomically:YES];
}

-(BOOL) isVerified {
    NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSNumber *verified = [savedData objectForKey:@"verified"];
    
    
    if (verified && [verified isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        NSLog(@"Account verified");
        return YES;
    } else {
        NSLog(@"Account not verified");
        return NO;
    }
}


-(void) saveMsg: (Msg *) packet{
    [self saveMsg:packet sent:[NSNumber numberWithBool:YES]];
}

-(void) saveMsgSentAtIndex : (NSInteger) index {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableArray *msgArray = [NSMutableArray arrayWithArray:[self loadMsg]];
    
    if (!msgArray) {
        msgArray = [[NSMutableArray alloc] init];
    }
    
    MsgObject *msgObject = [msgArray objectAtIndex:index];
    msgObject.sent = [NSNumber numberWithBool:YES];
    
    NSLog(@"MSG INDEX %@", [msgObject msgIndex]);

    [msgArray replaceObjectAtIndex:index withObject:msgObject];
    [archiver encodeObject:msgArray forKey:@"msgArray"];
    [archiver finishEncoding];
    
    [data setObject:dataObject forKey:@"msgArray"];
    [data writeToFile: path atomically:YES];
}
-(void) saveMsgAtIndex: (Msg*)packet :(NSNumber *) index {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableArray *msgArray = [NSMutableArray arrayWithArray:[self loadMsg]];
    
    if (!msgArray) {
        msgArray = [[NSMutableArray alloc] init];
    }
    
    MsgObject *msgObject = [[MsgObject alloc] initWithData:packet :[NSNumber numberWithBool:YES] :index];
    [msgArray replaceObjectAtIndex:[index integerValue] withObject:msgObject];
    
    NSLog(@"MSG INDEX %@", index);
    [archiver encodeObject:msgArray forKey:@"msgArray"];
    [archiver finishEncoding];
    
    [data setObject:dataObject forKey:@"msgArray"];
    [data writeToFile: path atomically:YES];

}
-(void) saveMsg: (Msg *) packet sent: (NSNumber *) sent {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableArray *msgArray = [NSMutableArray arrayWithArray:[self loadMsg]];
    
    if (!msgArray) {
        msgArray = [[NSMutableArray alloc] init];
    }
    
    MsgObject *msgObject = [[MsgObject alloc] initWithData:packet :sent :[NSNumber numberWithInt:[msgArray count]]];
    NSLog(@"MSG INDEX %@", [NSNumber numberWithInt:[msgArray count]]);

    [msgArray addObject:msgObject];
    [archiver encodeObject:msgArray forKey:@"msgArray"];
    [archiver finishEncoding];
    
    [data setObject:dataObject forKey:@"msgArray"];
    [data writeToFile: path atomically:YES];
}

-(void) savePull: (NSDictionary *) packet{
    [self getFile];

    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableArray *pullArray = [NSMutableArray arrayWithArray:[self loadPull]];
    
    if (!pullArray) {
        pullArray = [[NSMutableArray alloc] init];
    }
    
//    MsgObject *msgObject = [[MsgObject alloc] initWithData:packet :sent :[NSNumber numberWithInt:[msgArray count]]];
    NSLog(@"MSG INDEX %@", [NSNumber numberWithInt:[pullArray count]]);
    
    [pullArray addObject:packet];
    [archiver encodeObject:pullArray forKey:@"pullArray"];
    [archiver finishEncoding];
    
    [data setObject:dataObject forKey:@"pullArray"];
    [data writeToFile: path atomically:YES];
}

-(void) saveResource: (Resource *) packet {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[self loadResource]];
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[[NSMutableArray alloc] init] forKey:start];
        [dict setObject:[[NSMutableArray alloc] init] forKey:walking];
        [dict setObject:[[NSMutableArray alloc] init] forKey:fruitVeg];
        [dict setObject:[[NSMutableArray alloc] init] forKey:snacking];
        [dict setObject:[[NSMutableArray alloc] init] forKey:fastFoods];
        [dict setObject:[[NSMutableArray alloc] init] forKey:drinks];
        [dict setObject:[[NSMutableArray alloc] init] forKey:meals];
    }
    
    if ([[packet getCategory] isEqualToString:start]) {
        NSMutableArray *array = [dict objectForKey:start];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        [array addObject:packet];
        [dict setObject:array forKey:start];
    } else if ([[packet getCategory] isEqualToString:walking]) {
        NSMutableArray *array = [dict objectForKey:walking];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        [array addObject:packet];
        [dict setObject:array forKey:walking];
    } else if ([[packet getCategory] isEqualToString:fruitVeg]) {
        NSMutableArray *array = [dict objectForKey:fruitVeg];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        [array addObject:packet];
        [dict setObject:array forKey:fruitVeg];
    } else if ([[packet getCategory] isEqualToString:snacking]) {
        NSMutableArray *array = [dict objectForKey:snacking];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        [array addObject:packet];
        [dict setObject:array forKey:snacking];
    } else if ([[packet getCategory] isEqualToString:fastFoods]) {
        NSMutableArray *array = [dict objectForKey:fastFoods];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        [array addObject:packet];
        [dict setObject:array forKey:fastFoods];
    } else if ([[packet getCategory] isEqualToString:drinks]) {
        NSMutableArray *array = [dict objectForKey:drinks];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        [array addObject:packet];
        [dict setObject:array forKey:drinks];
    } else if ([[packet getCategory] isEqualToString:meals]) {
        NSMutableArray *array = [dict objectForKey:meals];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        [array addObject:packet];
        [dict setObject:array forKey:meals];
    }
    
    
    [archiver encodeObject:dict forKey:@"resources"];
    [archiver finishEncoding];
    
    [data setObject:dataObject forKey:@"resources"];
    [data writeToFile: path atomically:YES];
}


-(Resource *) loadResourceForID: (NSNumber*) resource_id {
    NSDictionary *dict = [self loadResource];
    
    NSArray *array = [NSArray arrayWithArray:[dict objectForKey:start]];
    for (Resource *resource in array) {
        if ([[resource getResource_id] isEqualToNumber:resource_id]) {
            return resource;
        }
    }
    
    array = [NSArray arrayWithArray:[dict objectForKey:walking]];
    for (Resource *resource in array) {
        if ([[resource getResource_id] isEqualToNumber:resource_id]) {
            return resource;
        }
    }
    array = [NSArray arrayWithArray:[dict objectForKey:fruitVeg]];
    for (Resource *resource in array) {
        if ([[resource getResource_id] isEqualToNumber:resource_id]) {
            return resource;
        }
    }
    array = [NSArray arrayWithArray:[dict objectForKey:snacking]];
    for (Resource *resource in array) {
        if ([[resource getResource_id] isEqualToNumber:resource_id]) {
            return resource;
        }
    }
    array = [NSArray arrayWithArray:[dict objectForKey:fastFoods]];
    for (Resource *resource in array) {
        if ([[resource getResource_id] isEqualToNumber:resource_id]) {
            return resource;
        }
    }
    array = [NSArray arrayWithArray:[dict objectForKey:drinks]];
    for (Resource *resource in array) {
        if ([[resource getResource_id] isEqualToNumber:resource_id]) {
            return resource;
        }
    }
    array = [NSArray arrayWithArray:[dict objectForKey:meals]];
    for (Resource *resource in array) {
        if ([[resource getResource_id] isEqualToNumber:resource_id]) {
            return resource;
        }
    }
    return nil;
}
-(void) saveTailoredGoal: (TailoredGoal *) packet {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[self loadTailoredGoal]];
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[[NSMutableArray alloc] init] forKey:@"active"];
        [dict setObject:[[NSMutableArray alloc] init] forKey:@"achieved"];
    }
    
    BOOL isOnfile = NO;
    NSInteger index = 0;
    NSMutableArray *checkArray = [NSMutableArray arrayWithArray:[dict objectForKey:@"active"]];
    //check if already on file
    for (TailoredGoal *goal in checkArray) {
        if ([[goal getTailored_goal_id] isEqualToNumber:[packet getTailored_goal_id]]) {
            if ([[goal getStatus] isEqualToNumber:[packet getStatus]]) {
//                NSLog(@"REPLACING OBJECT AT INDEX %d", index);
                [[dict objectForKey:@"active"] replaceObjectAtIndex:index withObject:packet];

            } else if ([[packet getStatus] isEqualToNumber:[NSNumber numberWithInt:1]]){
                //                NSLog(@"REMOVING OBJECT AT INDEX %d", index);
                if ([[dict objectForKey:@"active"] length] > index ) {
                    [[dict objectForKey:@"active"] removeObjectAtIndex:index];
                    NSLog(@"REMOVING OBJECT AT INDEX %d", index);
                }
////                [[dict objectForKey:@"achieved"] addObject:packet];
            } else {
//                NSLog(@"REMOVING OBJECT AT INDEX %d", index);
                [[dict objectForKey:@"active"] removeObjectAtIndex:index];
                [[dict objectForKey:@"achieved"] addObject:packet];
            }
            isOnfile = YES;
            continue;
        }
        index++;
    }
    if (!isOnfile) {
        index = 0;
        checkArray = [NSMutableArray arrayWithArray:[dict objectForKey:@"achieved"]];
        for (TailoredGoal *goal in checkArray) {
            if ([[goal getTailored_goal_id] isEqualToNumber:[packet getTailored_goal_id]]) {
                if ([[goal getStatus] isEqualToNumber:[packet getStatus]]) {
//                    NSLog(@"REPLACING OBJECT AT INDEX %d", index);
                    [[dict objectForKey:@"achieved"] replaceObjectAtIndex:index withObject:packet];
                } else {
//                    NSLog(@"REMOVING OBJECT AT INDEX %d", index);

                    [[dict objectForKey:@"achieved"] removeObjectAtIndex:index];
                    [[dict objectForKey:@"active"] addObject:packet];
                }

                isOnfile = YES;
                continue;
            }
            index++;
        }
    }
    if (!isOnfile) {
        if ([[packet getStatus] isEqualToNumber:[NSNumber numberWithInt:2]]) { //active goal
            
            NSMutableArray *array = [dict objectForKey:@"active"];
            if (!array) {
                array = [[NSMutableArray alloc] init];
            }
            [array addObject:packet];
            [dict setObject:array forKey:@"active"];
        } else if ([[packet getStatus] isEqualToNumber:[NSNumber numberWithInt:3]]) { //achieved goal
            NSMutableArray *array = [dict objectForKey:@"achieved"];
            if (!array) {
                array = [[NSMutableArray alloc] init];
            }
            [array addObject:packet];
            [dict setObject:array forKey:@"achieved"];
            
        }
    }

    [archiver encodeObject:dict forKey:@"tailoredGoals"];
    [archiver finishEncoding];

    [data setObject:dataObject forKey:@"tailoredGoals"];
    [data writeToFile: path atomically:YES];

}

-(void) clearPull {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableArray *pullArray = [[NSMutableArray alloc] init];
    
    [archiver encodeObject:pullArray forKey:@"pullArray"];
    [archiver finishEncoding];
    
    [data setObject:dataObject forKey:@"pullArray"];
    [data writeToFile: path atomically:YES];
}

-(void) clearMsgs {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableArray *msgArray = [[NSMutableArray alloc] init];

    [archiver encodeObject:msgArray forKey:@"msgArray"];
    [archiver finishEncoding];
    
    [data setObject:dataObject forKey:@"msgArray"];
    [data writeToFile: path atomically:YES];
}

-(void) clearTailoredGoals {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
//    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [dict setObject:[[NSMutableArray alloc] init] forKey:@"active"];
    [dict setObject:[[NSMutableArray alloc] init] forKey:@"achieved"];

    [archiver encodeObject:dict forKey:@"tailoredGoals"];
    [archiver finishEncoding];
    
    [data setObject:dataObject forKey:@"tailoredGoals"];
    [data writeToFile: path atomically:YES];
}

-(void) clearResources {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSMutableData *dataObject = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataObject];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[[NSMutableArray alloc] init] forKey:start];
    [dict setObject:[[NSMutableArray alloc] init] forKey:walking];
    [dict setObject:[[NSMutableArray alloc] init] forKey:fruitVeg];
    [dict setObject:[[NSMutableArray alloc] init] forKey:snacking];
    [dict setObject:[[NSMutableArray alloc] init] forKey:fastFoods];
    [dict setObject:[[NSMutableArray alloc] init] forKey:drinks];
    [dict setObject:[[NSMutableArray alloc] init] forKey:meals];

    
    [archiver encodeObject:dict forKey:@"resources"];
    [archiver finishEncoding];
    
    [data setObject:dataObject forKey:@"resources"];
    [data writeToFile: path atomically:YES];
}

-(NSArray *) loadMsg {
    NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
//    NSLog(@"MSGES %d", [[savedData objectForKey:@"msgArray"] count]);
    
    NSKeyedUnarchiver  *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:(NSData *) [savedData objectForKey:@"msgArray"]];
    
    NSMutableArray *array = [unarchiver decodeObjectForKey:@"msgArray"];
    if (array) {
        return [NSArray arrayWithArray:array];
    }
    return nil;
}

-(NSArray *) loadPull {
    NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    //    NSLog(@"MSGES %d", [[savedData objectForKey:@"msgArray"] count]);
    
    NSKeyedUnarchiver  *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:(NSData *) [savedData objectForKey:@"pullArray"]];
    
    NSMutableArray *array = [unarchiver decodeObjectForKey:@"pullArray"];
    if (array) {
        return [NSArray arrayWithArray:array];
    }
    return nil;
}


-(NSDictionary *) loadResource {
    NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    
    NSKeyedUnarchiver  *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:((NSData *) [savedData objectForKey:@"resources"])];
    
    NSMutableDictionary *dict = [unarchiver decodeObjectForKey:@"resources"];
    if (dict) {
        return [NSDictionary dictionaryWithDictionary:dict];
    }
    return nil;
}
-(NSDictionary *) loadTailoredGoal {
    NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];


    NSKeyedUnarchiver  *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:((NSData *) [savedData objectForKey:@"tailoredGoals"])];
    
    NSMutableDictionary *dict = [unarchiver decodeObjectForKey:@"tailoredGoals"];
    if (dict) {
        
//        TailoredGoal* tailoredGoal = [[dict objectForKey:@"active"] objectAtIndex:0];
//        NSLog(@"Tailored %@", [tailoredGoal getContent]);
        
        
        return [NSDictionary dictionaryWithDictionary:dict];
    }
    return nil;
}




@end
