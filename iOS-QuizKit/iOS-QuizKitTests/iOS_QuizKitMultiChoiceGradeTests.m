//
//  iOS_QuizKitMultiChoiceGradeTests.m
//  iOS-QuizKit
//
//  Created by Christian French on 02/04/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ISQuizKit.h"
@interface iOS_QuizKitMultiChoiceGradeTests : XCTestCase

@end

@implementation iOS_QuizKitMultiChoiceGradeTests

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

- (void)testCorrect2Options
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:NO];
    
    [question addOptions:@[option1,option2]];
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithAnswerIndex:0];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

- (void)testIncorrect2Options
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:NO];
    
    [question addOptions:@[option1,option2]];
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithAnswerIndex:1];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}
@end
