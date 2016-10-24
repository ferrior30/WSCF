//
//  WSCFTests.m
//  WSCFTests
//
//  Created by ChenWei on 16/10/16.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkTool.h"
#import "NetworkTool.h"


@interface WSCFTests : XCTestCase

@end

@implementation WSCFTests

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

- (void)testNetwork {
    NSDictionary *dicr =  @{@"device": @"iPhone8,1",
                            @"machine": @"Oe465ee7d2c21f604916deace6307de8014615245",
                            @"version": @"12.8.2.1",
                            };
    
    NSString *URL = @"http://api.ecook.cn/public/getDifferentHomedata.shtml";
    
    [[NetworkTool sharManager] POST:URL parameters:dicr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
