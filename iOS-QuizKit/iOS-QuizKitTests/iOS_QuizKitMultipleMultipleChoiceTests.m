//
//  iOS_QuizKitMultipleMultipleChoiceTests.m
//  iOS-QuizKit
//
//  Created by Christian French on 30/04/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ISMultipleChoiceQuestion.h"
#import "ISMultipleMultipleChoiceQuestion.h"
#import "ISMultipleMultipleChoiceQuestion+Private.h"
@interface iOS_QuizKitMultipleMultipleChoiceTests : XCTestCase

@end

@implementation iOS_QuizKitMultipleMultipleChoiceTests

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

-(void)test_AddQuestion {
    
    ISMultipleChoiceQuestion* multipleChoiceQuestion = [ISMultipleChoiceQuestion new];
    
    ISMultipleMultipleChoiceQuestion* multipleMultipleChoiceQuestion = [ISMultipleMultipleChoiceQuestion new];
    
    [multipleMultipleChoiceQuestion addQuestion:multipleChoiceQuestion];
    
    XCTAssertTrue(multipleMultipleChoiceQuestion.questions.count, @"should ahve 1 question");
}


-(void)test_OneQuestion_OneSelected_correct {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    ISMultipleMultipleChoiceQuestion* multipleMultipleChoiceQuestion = [ISMultipleMultipleChoiceQuestion questionWithQuestions:@[question]];
    
    XCTAssertTrue(multipleMultipleChoiceQuestion.options.count == 1, @"should have one option group");
    
    NSArray* options =  multipleMultipleChoiceQuestion.options[0];
    
    XCTAssertTrue(options.count == 4, @"should have 4 options in first group");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@1] ]];
    
    BOOL correct = [multipleMultipleChoiceQuestion responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

-(void)test_OneQuestion_OneSelected_incorrect {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    ISMultipleMultipleChoiceQuestion* multipleMultipleChoiceQuestion = [ISMultipleMultipleChoiceQuestion questionWithQuestions:@[question]];
    
    XCTAssertTrue(multipleMultipleChoiceQuestion.options.count == 1, @"should have one option group");
    
    NSArray* options =  multipleMultipleChoiceQuestion.options[0];
    
    XCTAssertTrue(options.count == 4, @"should have 4 options in first group");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@0] ]];
    
    BOOL correct = [multipleMultipleChoiceQuestion responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

-(void)test_TwoQuestion_OneSelectedEach_correct {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    ISMultipleChoiceQuestion* question1 = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* question1option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* question1option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* question1option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* question1option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question1 addOptions:@[question1option1,question1option2,question1option3,question1option4]];
    
    ISMultipleMultipleChoiceQuestion* multipleMultipleChoiceQuestion = [ISMultipleMultipleChoiceQuestion questionWithQuestions:@[question,question1]];
    
    XCTAssertTrue(multipleMultipleChoiceQuestion.options.count == 2, @"should have 2 option groups");
    
    NSArray* options1 =  multipleMultipleChoiceQuestion.options[0];
    
    NSArray* options2 =  multipleMultipleChoiceQuestion.options[0];
    
    XCTAssertTrue(options1.count == 4, @"should have 4 options in 1 group");

    XCTAssertTrue(options2.count == 4, @"should have 4 options in 2 group");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@1] , @[@1] ]];
    
    BOOL correct = [multipleMultipleChoiceQuestion responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
}

-(void)test_TwoQuestion_OneSelectedEach_incorrect {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    ISMultipleChoiceQuestion* question1 = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* question1option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* question1option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* question1option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* question1option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question1 addOptions:@[question1option1,question1option2,question1option3,question1option4]];
    
    ISMultipleMultipleChoiceQuestion* multipleMultipleChoiceQuestion = [ISMultipleMultipleChoiceQuestion questionWithQuestions:@[question,question1]];
    
    XCTAssertTrue(multipleMultipleChoiceQuestion.options.count == 2, @"should have 2 option groups");
    
    NSArray* options1 =  multipleMultipleChoiceQuestion.options[0];
    
    NSArray* options2 =  multipleMultipleChoiceQuestion.options[0];
    
    XCTAssertTrue(options1.count == 4, @"should have 4 options in 1 group");
    
    XCTAssertTrue(options2.count == 4, @"should have 4 options in 2 group");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@0] , @[@3] ]];
    
    BOOL correct = [multipleMultipleChoiceQuestion responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

-(void)test_TwoQuestion_OneSelectedEachOneCorrectOneIncorrect_incorrect {
    
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4]];
    
    ISMultipleChoiceQuestion* question1 = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* question1option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:NO];
    
    ISMultipleChoiceOption* question1option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* question1option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:NO];
    
    [question1 addOptions:@[question1option1,question1option2,question1option3]];
    
    ISMultipleMultipleChoiceQuestion* multipleMultipleChoiceQuestion = [ISMultipleMultipleChoiceQuestion questionWithQuestions:@[question,question1]];
    
    XCTAssertTrue(multipleMultipleChoiceQuestion.options.count == 2, @"should have 2 option groups");
    
    NSArray* options1 =  multipleMultipleChoiceQuestion.options[0];
    
    NSArray* options2 =  multipleMultipleChoiceQuestion.options[1];
    
    XCTAssertTrue(options1.count == 4, @"should have 4 options in 1 group");
    
    XCTAssertTrue(options2.count == 3, @"should have 4 options in 2 group");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@1] , @[@2] ]];
    
    BOOL correct = [multipleMultipleChoiceQuestion responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
}

@end
