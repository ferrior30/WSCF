//
//  NSString+CWNSDate.m
//  WSCF
//
//  Created by ChenWei on 16/10/23.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+CWNSDate.h"

@interface NSString_CWNSDate : XCTestCase


@end

@implementation NSString_CWNSDate

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testNSDate {
    NSDate *date = [NSDate date];
    
    NSLog(@"%@", [NSString cw_stringWithDate:date]);
}


@end
