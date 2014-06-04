//
//  Resource.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/15/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Packet.h"

//
//  Msg.h
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/15/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Packet.h"

@interface Resource : Packet <NSCoding> {
@private
    NSNumber *resource_id;
    NSString *name;
    NSString *category;
    NSString *content;

}

-(id) init: (NSNumber *) resource_id_ : (NSString *) name_ :  (NSString *) category_ :  (NSString *) content_;
-(id) init: (NSDictionary *) dict;
-(NSString *) toString;
-(void) setResource_id:(NSNumber *)resource_id_;
-(void) setName:(NSString *)name_;
-(void) setCategory:(NSString *)category_;
-(void) setContent:(NSString *)content_;
-(NSNumber*) getResource_id;
-(NSString*) getName;
-(NSString*) getCategory;
-(NSString*) getContent;



@end
