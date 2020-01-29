//
//  ViewController.m
//  MemoryManagement
//
//  Created by Paul Solt on 1/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
#import "Person.h"
#import "LSILog.h"

@interface ViewController ()
@property (nonatomic, retain) NSMutableArray *people;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // TODO: Disable ARC in settings
    
    NSLog(@"Hi");
    
    NSString *jsonString = [[NSString alloc] initWithString:@"{ \"name\" : \"Brandi\" }"];
    NSLog(@"jsonString: %p", jsonString);
    // ^^ Retain count = 1
    // vv Reatin count = 1
    NSString *alias = [jsonString retain];
    NSLog(@"alias: %p", alias);
    
    [alias release]; // Retain count = 1
    alias = nil; // Clear out variable so we don't accidentally use it
    
    NSLog(@"json: %@", jsonString);
    [jsonString release];
    jsonString = nil;
    
    NSLog(@"json: %@", jsonString);
    
    // Collections are going to take ownership of the data we give them
//    NSString *jim = [[NSString alloc] initWithString:@"Jim"];  // jim: 1
//
//    NSMutableArray *people = [[NSMutableArray alloc] init]; // people: 1
//
//    [people addObject:jim]; // jim: 2
//    [people removeObject:jim]; // jim: 1
    
    // Collections are going to take ownership of the data we give them
    
    NSString *jim = [[NSString alloc] initWithString:@"Jim"];  // jim: 1
    
    // Typically we'll craete our arrays using ivar in init method
    _people = [[NSMutableArray alloc] init]; // people: 1
    
    [self.people addObject:jim]; // jim: 2 (array calls retain on the object we pass it)
    [jim release]; // transfer ownership to the collection.  Jim: 1
    
//    [self.people removeObject:jim]; // jim: 1 (array calls release when removing an object)
    
    Car *honda = [Car carWithMake:@"Civic"];
//    Car *honda = [[Car alloc] initWithMake:@"Civic"]; // honda: 1
    Person *sarah = [[Person alloc] initWithCar:honda]; // honda: 2, sarah: 1;
//    [honda release]; // honda: 1, transferring ownership of of car
    [sarah release]; // sarah: 0, honda: 0
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", @"John", @"Miller"];
    // Autoreleased?  or not (YES, no it's not)
    // Yes, because it's stringWithFormat, not initWithFormat
    NSDate *today = [NSDate date];
    // YES
    
    NSDate *now = [NSDate new];
    // NO, because new
    
    NSDate *tomorrow2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    // YES, no alloc init or new
    
    NSDate *nextTomorrow = [tomorrow2 copy]; // retain: 1
    // NO, because copy
    
    NSArray *words = [@"This sentence is the bomb" componentsSeparatedByString:@" "];
    // YES, because we're not saying new, alloc, or init
    
    NSString *idea = [[NSString alloc] initWithString:@"Hello Ideas"];
    // NO, because alloc
    
    Car *redCar = [Car carWithMake:@"Civic"];
    // YES
    
    NSString *idea2 = [[[NSString alloc] initWithString:@"Hello Ideas"] autorelease];
    // YES, there's a call to autorelease
    
    NSString *idea3 = [[NSString alloc] initWithString:@"Hello Ideas"];
    // NO
    [idea3 autorelease];
    // But now yes
    
    [now release];
    [nextTomorrow release];
    [idea release];
    
}

- (void)dealloc {
    [_people release]; // Calls release on all objects inside // Jim: 0, people: 0
    _people = nil;
    
    [super dealloc];
}


@end
