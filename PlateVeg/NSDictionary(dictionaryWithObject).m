//
//  NSDictionary(dictionaryWithObject).m
//  Test
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "NSDictionary(dictionaryWithObject).h"

@implementation NSDictionary(dictionaryWithObject)

+(NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if ([obj valueForKey:key]  != nil) {
            [dict setObject:[obj valueForKey:key] forKey:key];
        }
    }
    
    free(properties);
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end