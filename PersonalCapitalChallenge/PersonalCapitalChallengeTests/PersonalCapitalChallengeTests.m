//
//  PersonalCapitalChallengeTests.m
//  PersonalCapitalChallengeTests
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+CheckNull.h"

@interface PersonalCapitalChallengeTests : XCTestCase

@end

@implementation PersonalCapitalChallengeTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample
{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *testString = @"testString";
    XCTAssertEqualObjects([testString returnEmptyStringForNull], @"testString");
    // uncomment below code to fail
    /*
    testString = nil;
    XCTAssertEqualObjects([testString returnEmptyStringForNull], @"testString");
     */
}

- (void)testAsynchronousURLConnection
{
    NSURL *URL = [NSURL URLWithString:@"https://www.personalcapital.com/blog/feed/json"];
    NSString *description = [NSString stringWithFormat:@"GET %@", URL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        XCTAssertNotNil(data, "data should not be nil");
        XCTAssertNil(error, "error should be nil");

        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
            XCTAssertEqualObjects(httpResponse.URL.absoluteString, URL.absoluteString, @"HTTP response URL should be equal to original URL");
            // uncomment below code to fail
            /*
             XCTAssertEqualObjects(httpResponse.MIMEType, @"text/html", @"HTTP response content type should be text/html");
             */
            XCTAssertEqualObjects(httpResponse.MIMEType, @"application/json", @"HTTP response content type should be text/html");
        }
        else
        {
            XCTFail(@"Response was not NSHTTPURLResponse");
        }

        [expectation fulfill];
    }];

    [task resume];

    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
