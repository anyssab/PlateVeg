//
//  NSDictionary(dictionaryWithObject).h
//  Test
//
//  Created by Ross Tang Him on 6/7/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface NSDictionary(dictionaryWithObject)

+(NSDictionary *) dictionaryWithPropertiesOfObject:(id) obj;

@end
