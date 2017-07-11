//
//  ISOpenQuestionTests.m
//  iOS-QuizKit
//
//  Created by Christian French on 23/06/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ISOpenQuestion.h"
@interface ISOpenQuestionTests : XCTestCase

@end

@implementation ISOpenQuestionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testCorrect
{
    ISOpenQuestion* question = [ISOpenQuestion new];
    
    question.text = @"Type number 4";
    
    question.matchMode = kISOpenQuestionMatchModeExact;
    
    [question addAnswer:@"4"];
    
    ISOpenQuestionResponse* response = [ISOpenQuestionResponse responseWithResponse:@"4"];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

- (void)testIncorrect
{
    ISOpenQuestion* question = [ISOpenQuestion new];
    
    question.text = @"Type number 4";
    
    question.matchMode = kISOpenQuestionMatchModeExact;
    
    [question addAnswer:@"4"];
    
    ISOpenQuestionResponse* response = [ISOpenQuestionResponse responseWithResponse:@"four"];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

- (void)testCorrectContainsMatchMode
{
    ISOpenQuestion* question = [ISOpenQuestion new];
    
    question.text = @"Type number 4 and 5";
    
    question.matchMode = kISOpenQuestionContainsAll;
    
    [question addAnswer:@"4"];
    
     [question addAnswer:@"5"];
    
    ISOpenQuestionResponse* response = [ISOpenQuestionResponse responseWithResponse:@"4 and 5"];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

- (void)testHalfIncorrectContainsMatchMode
{
    ISOpenQuestion* question = [ISOpenQuestion new];
    
    question.text = @"Type number 4 and 5";
    
    question.matchMode = kISOpenQuestionContainsAll;
    
    [question addAnswer:@"4"];
    
    [question addAnswer:@"5"];
    
    ISOpenQuestionResponse* response = [ISOpenQuestionResponse responseWithResponse:@"4 and five"];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

- (void)testIncorrectContainsMatchMode
{
    ISOpenQuestion* question = [ISOpenQuestion new];
    
    question.text = @"Type number 4 and 5";
    
    question.matchMode = kISOpenQuestionContainsAll;
    
    [question addAnswer:@"4"];
    
    [question addAnswer:@"5"];
    
    ISOpenQuestionResponse* response = [ISOpenQuestionResponse responseWithResponse:@"four and five"];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

@end
