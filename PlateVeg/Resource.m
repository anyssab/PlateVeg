//
//  Resource.m
//  DASH_1.0
//
//  Created by Ross Tang Him on 8/15/13.
//  Copyright (c) 2013 smart_parking. All rights reserved.
//

#import "Resource.h"

@interface Resource ()
@property (nonatomic) NSNumber *resource_id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *category;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *typeOfPacket;
@property (nonatomic) NSString *date;

@end

@implementation Resource
@synthesize resource_id,name,category,content;

-(id) init: (NSNumber *) resource_id_ : (NSString *) name_ :  (NSString *) category_ :  (NSString *) content_{
    if ( self = [super init] ) {
        [super setTypeOfPacket:@"Resource"];
        resource_id = resource_id_;
        name = name_;
        category = category_;
        content = content_;
        [super setDate:@"NIL"];

    }
    return self;
}

-(id) init: (NSDictionary *) dict {
    if (self = [super init]) {
        [super setTypeOfPacket:@"Resource"];
        resource_id = [dict objectForKey:@"resource_id"];
        name = [dict objectForKey:@"name"];
        category = [dict objectForKey:@"category"];
        content = [dict objectForKey:@"content"];
        [super setDate:@"NIL"];

    }
    return self;
}

-(NSString *) toString{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:self];
    NSString *jsonString = [writer stringWithObject:dict];
    return jsonString;
}

-(void) setResource_id:(NSNumber *)resource_id_ {
    resource_id = resource_id_;
}

-(void) setName:(NSString *)name_ {
    name = name_;
}

-(void) setCategory:(NSString *)category_ {
    category = category_;
}

-(void) setContent:(NSString *)content_ {
    content = content_;
}
-(NSNumber*) getResource_id {
    return resource_id;
}

-(NSString*) getName {
    return name;
}
-(NSString*) getCategory {
    return category;
}
-(NSString*) getContent {
    return content;
}


- (void)encodeWithCoder:(NSCoder *) coder
{
    [coder encodeObject:resource_id forKey:@"resource_id"];
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:category forKey:@"category"];
    [coder encodeObject:content forKey:@"content"];
    [coder encodeObject:typeOfPacket forKey:@"typeOfPacket"];
    [coder encodeObject:date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [super setTypeOfPacket:[decoder decodeObjectForKey:@"typeOfPacket"]];
        [self setResource_id: [decoder decodeObjectForKey:@"resource_id"]];
        [self setName: [decoder decodeObjectForKey:@"name"]];
        [self setCategory: [decoder decodeObjectForKey:@"category"]];
        [self setContent: [decoder decodeObjectForKey:@"content"]];
        [super setDate: [decoder decodeObjectForKey:@"date"]];
    }
    return self;
}

@end
