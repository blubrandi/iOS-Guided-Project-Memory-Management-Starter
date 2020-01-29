//
//  Car.h
//  MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic, copy) NSString *make;

- (instancetype)initWithMake:(NSString *)make;

// TODO: Create an autoreleased class method to create a Car

+ (instancetype)carWithMake:(NSString *)make;
@end
