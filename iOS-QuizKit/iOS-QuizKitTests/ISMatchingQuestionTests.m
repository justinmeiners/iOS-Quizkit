//
//  ISMatchingQuestionTests.m
//  iOS-QuizKit
//
//  Created by Christian French on 17/06/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ISMatchingQuestion.h"
@interface ISMatchingQuestionTests : XCTestCase

@end

@implementation ISMatchingQuestionTests

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
    ISMatchingQuestion* question = [ISMatchingQuestion new];
    
    question.text = @"Match the numbers to the words";
    
    ISMatchingOption* answer1 = [ISMatchingOption optionWithText:@"1"];
    
    ISMatchingOption* answer2 = [ISMatchingOption optionWithText:@"2"];
    
    ISMatchingOption* answer3 = [ISMatchingOption optionWithText:@"3"];
    
    ISMatchingOption* answer4 = [ISMatchingOption optionWithText:@"4"];
    
    ISMatchingOption* option1 = [ISMatchingOption optionWithText:@"One" matchingOption:answer1];
    
    ISMatchingOption* option2 = [ISMatchingOption optionWithText:@"Two" matchingOption:answer2];
    
    ISMatchingOption* option3 = [ISMatchingOption optionWithText:@"Three" matchingOption:answer3];
    
    ISMatchingOption* option4 = [ISMatchingOption optionWithText:@"Four" matchingOption:answer4];
    
    question.options = @[option1,option2,option3,option4];
    
    question.answers = @[answer1,answer2,answer3,answer4];
    
    ISMatchingResponse* response = [ISMatchingResponse responseWithOptions:@[answer1,answer2,answer3,answer4]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

- (void)testIncorrect
{
    ISMatchingQuestion* question = [ISMatchingQuestion new];
    
    question.text = @"Match the numbers to the words";
    
    ISMatchingOption* answer1 = [ISMatchingOption optionWithText:@"1"];
    
    ISMatchingOption* answer2 = [ISMatchingOption optionWithText:@"2"];
    
    ISMatchingOption* answer3 = [ISMatchingOption optionWithText:@"3"];
    
    ISMatchingOption* answer4 = [ISMatchingOption optionWithText:@"4"];
    
    ISMatchingOption* option1 = [ISMatchingOption optionWithText:@"One" matchingOption:answer1];
    
    ISMatchingOption* option2 = [ISMatchingOption optionWithText:@"Two" matchingOption:answer2];
    
    ISMatchingOption* option3 = [ISMatchingOption optionWithText:@"Three" matchingOption:answer3];
    
    ISMatchingOption* option4 = [ISMatchingOption optionWithText:@"Four" matchingOption:answer4];
    
    question.options = @[option1,option2,option3,option4];
    
    question.answers = @[answer1,answer2,answer3,answer4];
    
    ISMatchingResponse* response = [ISMatchingResponse responseWithOptions:@[answer2,answer1,answer3,answer4]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

- (void)testIncorrectOptionsNumber
{
    ISMatchingQuestion* question = [ISMatchingQuestion new];
    
    question.text = @"Match the numbers to the words";
    
    ISMatchingOption* answer1 = [ISMatchingOption optionWithText:@"1"];
    
    ISMatchingOption* answer2 = [ISMatchingOption optionWithText:@"2"];
    
    ISMatchingOption* answer3 = [ISMatchingOption optionWithText:@"3"];
    
    ISMatchingOption* answer4 = [ISMatchingOption optionWithText:@"4"];
    
    ISMatchingOption* option1 = [ISMatchingOption optionWithText:@"One" matchingOption:answer1];
    
    ISMatchingOption* option2 = [ISMatchingOption optionWithText:@"Two" matchingOption:answer2];
    
    ISMatchingOption* option3 = [ISMatchingOption optionWithText:@"Three" matchingOption:answer3];
    
    ISMatchingOption* option4 = [ISMatchingOption optionWithText:@"Four" matchingOption:answer4];
    
    question.options = @[option1,option2,option3,option4];
    
    question.answers = @[answer1,answer2,answer3,answer4];
    
    ISMatchingResponse* response = [ISMatchingResponse responseWithOptions:@[answer2,answer1,answer3]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

- (void)testRandomizedCorrect
{
    
    ISMatchingOption* answer1 = [ISMatchingOption optionWithText:@"1"];
    
    ISMatchingOption* answer2 = [ISMatchingOption optionWithText:@"2"];
    
    ISMatchingOption* answer3 = [ISMatchingOption optionWithText:@"3"];
    
    ISMatchingOption* answer4 = [ISMatchingOption optionWithText:@"4"];
    
    ISMatchingOption* option1 = [ISMatchingOption optionWithText:@"One" matchingOption:answer1];
    
    ISMatchingOption* option2 = [ISMatchingOption optionWithText:@"Two" matchingOption:answer2];
    
    ISMatchingOption* option3 = [ISMatchingOption optionWithText:@"Three" matchingOption:answer3];
    
    ISMatchingOption* option4 = [ISMatchingOption optionWithText:@"Four" matchingOption:answer4];
    
    ISMatchingQuestion* question = [ISMatchingQuestion questionWithOptions:@[option1,option2,option3,option4] answers:@[answer1,answer2,answer3,answer4]];
    
    question.text = @"Match the numbers to the words";
    
    NSMutableArray* answers = [NSMutableArray array];
    
    NSArray* text = @[@"1",@"2",@"3",@"4"];
    
    for (NSInteger i = 0 ; i < 4 ; i++) {
        
        NSUInteger idx = [question.randomizedAnswers indexOfObjectPassingTest:^BOOL(ISMatchingOption* obj, NSUInteger idx, BOOL *stop) {
          
            if([obj.text isEqualToString:text[i]]) {
                
                *stop = YES;
                
                return YES;
                
            }
            
            return NO;
        }];
        
        [answers addObject: question.randomizedAnswers[idx]];

    }
    
    ISMatchingResponse* response = [ISMatchingResponse responseWithOptions:answers];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be incorrect");
}

- (void)testRandomizedIncorrect
{
    
    ISMatchingOption* answer1 = [ISMatchingOption optionWithText:@"1"];
    
    ISMatchingOption* answer2 = [ISMatchingOption optionWithText:@"2"];
    
    ISMatchingOption* answer3 = [ISMatchingOption optionWithText:@"3"];
    
    ISMatchingOption* answer4 = [ISMatchingOption optionWithText:@"4"];
    
    ISMatchingOption* option1 = [ISMatchingOption optionWithText:@"One" matchingOption:answer1];
    
    ISMatchingOption* option2 = [ISMatchingOption optionWithText:@"Two" matchingOption:answer2];
    
    ISMatchingOption* option3 = [ISMatchingOption optionWithText:@"Three" matchingOption:answer3];
    
    ISMatchingOption* option4 = [ISMatchingOption optionWithText:@"Four" matchingOption:answer4];
    
    ISMatchingQuestion* question = [ISMatchingQuestion questionWithOptions:@[option1,option2,option3,option4] answers:@[answer1,answer2,answer3,answer4]];
    
    question.text = @"Match the numbers to the words";
    
    NSMutableArray* answers = [NSMutableArray array];
    
    NSArray* text = @[@"1",@"3",@"2",@"4"];
    
    for (NSInteger i = 0 ; i < 4 ; i++) {
        
        NSUInteger idx = [question.randomizedAnswers indexOfObjectPassingTest:^BOOL(ISMatchingOption* obj, NSUInteger idx, BOOL *stop) {
            
            if([obj.text isEqualToString:text[i]]) {
                
                *stop = YES;
                
                return YES;
                
            }
            
            return NO;
        }];
        
        [answers addObject: question.randomizedAnswers[idx]];
        
    }
    
    ISMatchingResponse* response = [ISMatchingResponse responseWithOptions:answers];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}


@end
