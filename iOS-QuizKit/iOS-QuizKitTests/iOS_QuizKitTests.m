//
//  iOS_QuizKitTests.m
//  iOS-QuizKitTests
//
//  Created by Christian French on 02/04/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ISQuizKit.h"

@interface iOS_QuizKitTests : XCTestCase

@end

@implementation iOS_QuizKitTests

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

- (void)testQuizLoad
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test.plist"];
    
    XCTAssertNotNil(quiz, @"quiz should not be nil");
}

- (void)testQuizQuestionCount
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test.plist"];
    
    XCTAssertTrue((quiz.questions.count == 5), @"question count %d should == 5",quiz.questions.count);
}

- (void)testQuizSessionCreation
{
    ISSession* session = [ISSession session];
    
    XCTAssertNotNil(session, @"session should not be nil");
}

- (void)testQuizSessionGradeAllCorrectResponses
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test.plist"];
    
    ISSession* session = [ISSession session];
    
    [session setResponse:[ISOpenQuestionResponse responseWithResponse:@"NSObject"] atIndex:0];
    [session setResponse:[ISOpenQuestionResponse responseWithResponse:@"gcd"] atIndex:1];
    [session setResponse:[ISOpenQuestionResponse responseWithResponse:@"NSOBJECT"] atIndex:2];
    [session setResponse:[ISMultipleChoiceResponse responseWithAnswerIndex:0] atIndex:3];
    [session setResponse:[ISTrueFalseResponse responseWithResponse:YES] atIndex:4];
    
    ISGradingResult* result = [quiz gradeSession:session];
    
    XCTAssertTrue((result.pointPercentage == 1.00f), @"result.pointPercentage %f should == 1.00",result.pointPercentage);
    
    XCTAssertTrue((result.points == 6), @"result.pointPercentage %d should == 6",result.points);
    
    XCTAssertTrue((result.pointsPossible == 6), @"result.pointsPossible %d should == 6",result.pointsPossible);
}

- (void)testQuizSessionGradeAllIncorrectResponses
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test.plist"];
    
    ISSession* session = [ISSession session];
    
    [session setResponse:[ISOpenQuestionResponse responseWithResponse:@"NSViewController"] atIndex:0];
    [session setResponse:[ISOpenQuestionResponse responseWithResponse:@"runtime"] atIndex:1];
    [session setResponse:[ISOpenQuestionResponse responseWithResponse:@"no idea"] atIndex:2];
    [session setResponse:[ISMultipleChoiceResponse responseWithAnswerIndex:1] atIndex:3];
    [session setResponse:[ISTrueFalseResponse responseWithResponse:NO] atIndex:4];
    
    ISGradingResult* result = [quiz gradeSession:session];
    
    XCTAssertTrue((result.pointPercentage == 0.00f), @"result.pointPercentage %f should == 0.00",result.pointPercentage);
    
    XCTAssertTrue((result.points == 0), @"result.pointPercentage %d should == 0",result.points);
    
    XCTAssertTrue((result.pointsPossible == 6), @"result.pointsPossible %d should == 6",result.pointsPossible);
}

/*
 Testing that the MultiChoice questions deserialize corectly
 */

- (void)testQuizSessionGradeAllMultiChoiceQuestionsCorrect
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test_multi_choice.plist"];
    
    ISSession* session = [ISSession session];
    
    [session setResponse:[ISMultipleChoiceResponse responseWithIndexes:@[@0,@1]] atIndex:0];
    [session setResponse:[ISMultipleChoiceResponse responseWithIndexes:@[@0,@1,@2]] atIndex:1];
    
    ISGradingResult* result = [quiz gradeSession:session];
    
    XCTAssertTrue((result.pointPercentage == 1.00f), @"result.pointPercentage %f should == 1.00",result.pointPercentage);
    
    XCTAssertTrue((result.points == 5), @"result.pointPercentage %d should == 5",result.points);
    
    XCTAssertTrue((result.pointsPossible == 5), @"result.pointsPossible %d should == 5",result.pointsPossible);
}

- (void)testQuizSessionGradeAllMultiChoiceQuestionsIncorrect
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test_multi_choice.plist"];
    
    ISSession* session = [ISSession session];
    
    [session setResponse:[ISMultipleChoiceResponse responseWithIndexes:@[@1,@2]] atIndex:0];
    [session setResponse:[ISMultipleChoiceResponse responseWithIndexes:@[@1,@2,@3]] atIndex:1];
    
    ISGradingResult* result = [quiz gradeSession:session];
    
    XCTAssertTrue((result.pointPercentage == 0.00f), @"result.pointPercentage %f should == 0.00",result.pointPercentage);
    
    XCTAssertTrue((result.points == 0), @"result.pointPercentage %d should == 0",result.points);
    
    XCTAssertTrue((result.pointsPossible == 5), @"result.pointsPossible %d should == 5",result.pointsPossible);
}

@end
