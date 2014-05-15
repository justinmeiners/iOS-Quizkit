//
//  iOS_QuizKitQuizParserTests.m
//  iOS-QuizKit
//
//  Created by Christian French on 02/05/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ISQuizParser.h"
#import "ISMultipleMultipleChoiceQuestion.h"
#import "ISMultipleMultipleChoiceQuestion+Private.h"
@interface iOS_QuizKitQuizParserTests : XCTestCase

@end

@implementation iOS_QuizKitQuizParserTests

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

- (void)testBasicParse
{
     NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString* path = [bundle pathForResource:@"quiz_test_multi_multi_choice" ofType:@"plist"];
    
    NSDictionary* quizData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    ISQuiz* quiz = [ISQuizParser quizFromDictionary:quizData];
    
    XCTAssertNotNil(quiz, @"should have a quiz");
    
    XCTAssertTrue(quiz.questions.count == 1, @"should have 1 question");
    
    XCTAssertTrue([quiz.questions[0] isKindOfClass:[ISMultipleMultipleChoiceQuestion class]], @"should have a MMChoice question");
    
    ISMultipleMultipleChoiceQuestion* question = (ISMultipleMultipleChoiceQuestion*)quiz.questions[0];

    XCTAssertTrue(question.questions.count == 3, @"should have 1 options");
    
    XCTAssertTrue(question.options.count == 3, @"should have 3 options");
    
    

}

@end
