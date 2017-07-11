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
    
    question.selectableOptions = @1;
    
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

/**
 Test for multiple selection
 
 **/

- (void)testCorrect2SelectedOptions
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    [question addOptions:@[option1,option2]];
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@0,@1]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

- (void)test_TwoCorrectSelected_FourCorrectOptions
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:YES];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    question.selectableOptions = @2;
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@0,@1]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

- (void)test_FirstAndSecondSelectedCorrectOptions_FromFourOptions
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    question.selectableOptions = @2;
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@0,@1]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

- (void)test_FirstAndLastTwoSelectedCorrectOptions_FromFourOptions
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:NO];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:YES];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    question.selectableOptions = @2;
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@0,@3]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

- (void)test_SecondAndThirdTwoSelectedCorrectOptions_FromFourOptions
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    question.selectableOptions = @2;
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@1,@2]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

- (void)testIncorrectTwoSelectedOptions
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@0,@3]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

- (void)testOneIncorrectOneCorrectTwoSelectedOptionsFromFour
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@0,@3]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

-(void)test_OneCorrectSelected_FromTwoCorrectOptions_WithFourPossibleOptions {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    question.selectableOptions = @2;
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@1]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

-(void)test_OneInCorrectSelected_FromTwoCorrectOptions_WithFourPossibleOptions {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    question.selectableOptions = @2;
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@0]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

-(void)test_ThreeSelected_FromTwoCorrectOptions_WithFourPossibleOptions {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[@1,@2,@3]];
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

/**
 Test for randomizing options
 
 **/

-(void)test_OneCorrect_fromRandomizedOptions {
 
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:NO];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];

    NSMutableArray* indexes = [NSMutableArray array];

    for (ISMultipleChoiceOption* option in question.randomizedOptions) {
        
        if([option.text isEqualToString:@"One"]) {
            
            [indexes addObject:[NSNumber numberWithInt:[question.randomizedOptions indexOfObject: option]]];
        }
    }
    
     ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:indexes];
    
    BOOL correct = [question responseCorrectForRandomizedOptions:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
    
}

-(void)test_TwoCorrect_fromRandomizedOptions {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:NO];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:YES];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    NSMutableArray* indexes = [NSMutableArray array];
    
    for (ISMultipleChoiceOption* option in question.randomizedOptions) {
        
        if([option.text isEqualToString:@"Two"] || [option.text isEqualToString:@"Four"]) {
            
            [indexes addObject:[NSNumber numberWithInt:[question.randomizedOptions indexOfObject: option]]];
        }
    }
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:indexes];
    
    BOOL correct = [question responseCorrectForRandomizedOptions:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
    
}

-(void)test_OneIncorrect_fromRandomizedOptions {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:NO];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    NSMutableArray* indexes = [NSMutableArray array];
    
    for (ISMultipleChoiceOption* option in question.randomizedOptions) {
        
        if([option.text isEqualToString:@"Two"]) {
            
            [indexes addObject:[NSNumber numberWithInt:[question.randomizedOptions indexOfObject: option]]];
        }
    }
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:indexes];
    
    BOOL correct = [question responseCorrectForRandomizedOptions:response];
    
    XCTAssertFalse(correct, @"answer correct: %d should be incorrect selections: %@ | options: %@",correct,indexes,question.randomizedOptions);
    
}

-(void)test_TwoIncorrect_fromRandomizedOptions {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:NO];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    NSMutableArray* indexes = [NSMutableArray array];
    
    for (ISMultipleChoiceOption* option in question.randomizedOptions) {
        
        if([option.text isEqualToString:@"Two"] || [option.text isEqualToString:@"Four"]) {
            
            [indexes addObject:[NSNumber numberWithInt:[question.randomizedOptions indexOfObject: option]]];
        }
    }
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:indexes];
    
    BOOL correct = [question responseCorrectForRandomizedOptions:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
    
}

-(void)test_OneCorrect_OneIncorrect_fromRandomizedOptions {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:NO];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    NSMutableArray* indexes = [NSMutableArray array];
    
    for (ISMultipleChoiceOption* option in question.randomizedOptions) {
        
        if([option.text isEqualToString:@"Three"] || [option.text isEqualToString:@"Four"]) {
            
            [indexes addObject:[NSNumber numberWithInt:[question.randomizedOptions indexOfObject: option]]];
        }
    }
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:indexes];
    
    BOOL correct = [question responseCorrectForRandomizedOptions:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
    
}

-(void)test_fourCorrect_fromRandomizedOptions {

    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    question.selectableOptions = @4;
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:YES];
    
    ISMultipleChoiceOption* option5 = [ISMultipleChoiceOption optionWithText:@"Five" correct:NO];
    
    ISMultipleChoiceOption* option6 = [ISMultipleChoiceOption optionWithText:@"Six" correct:NO];
    
    ISMultipleChoiceOption* option7 = [ISMultipleChoiceOption optionWithText:@"Seven" correct:NO];
    
    ISMultipleChoiceOption* option8 = [ISMultipleChoiceOption optionWithText:@"Eight" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4,option5,option6,option7,option8]];
    
    NSMutableArray* indexes = [NSMutableArray array];
    
    for (ISMultipleChoiceOption* option in question.randomizedOptions) {
        
        if([option.text isEqualToString:@"One"] || [option.text isEqualToString:@"Two"] || [option.text isEqualToString:@"Three"] || [option.text isEqualToString:@"Four"]) {
            
            [indexes addObject:[NSNumber numberWithInt:[question.randomizedOptions indexOfObject: option]]];
        }
    }
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:indexes];
    
    BOOL correct = [question responseCorrectForRandomizedOptions:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
    
}

@end
