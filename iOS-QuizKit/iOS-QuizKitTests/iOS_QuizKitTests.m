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

/*
 Testing that the MultiMultiChoice questions deserialize corectly
 */

- (void)testQuizSessionGradeAllMultiMultiChoiceQuestionsCorrect
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test_multi_multi_choice.plist"];
    
    ISSession* session = [ISSession session];
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@0] , @[@0] , @[@0] ]];
    
    [session setResponse:response atIndex:0];
    
    ISGradingResult* result = [quiz gradeSession:session];
    
    XCTAssertTrue((result.pointPercentage == 1.00f), @"result.pointPercentage %f should == 1.00",result.pointPercentage);
    
    XCTAssertTrue((result.points == 3), @"result.pointPercentage %d should == 3",result.points);
    
    XCTAssertTrue((result.pointsPossible == 3), @"result.pointsPossible %d should == 3",result.pointsPossible);
}

- (void)testQuizSessionGrade_AllMultiMultiChoiceQuestions_Incorrect
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test_multi_multi_choice.plist"];
    
    ISSession* session = [ISSession session];
    
    [session setResponse:[ISMultipleChoiceResponse responseWithIndexes:@[ @[@1] , @[@2] , @[@3] ]] atIndex:0];
    
    ISGradingResult* result = [quiz gradeSession:session];
    
    XCTAssertTrue((result.pointPercentage == 0.00f), @"result.pointPercentage %f should == 0.00",result.pointPercentage);
    
    XCTAssertTrue((result.points == 0), @"result.pointPercentage %d should == 3",result.points);
    
    XCTAssertTrue((result.pointsPossible == 3), @"result.pointsPossible %d should == 3",result.pointsPossible);
}

- (void)test_MultiMultiChoiceQuestion_MultipleSelectableOptions_correct
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test_multiple_multi_multi_choice.plist"];
    
    ISSession* session = [ISSession session];
    
    [session setResponse:[ISMultipleChoiceResponse responseWithIndexes:@[ @[@0] , @[@0] , @[@0] ]] atIndex:0];
    
    [session setResponse:[ISMultipleChoiceResponse responseWithIndexes:@[ @[@0,@1] , @[@0,@1] , @[@0,@1] ]] atIndex:1];
    
    ISGradingResult* result = [quiz gradeSession:session];
    
    XCTAssertTrue((result.pointPercentage == 1.00f), @"result.pointPercentage %f should == 1.00",result.pointPercentage);
    
    XCTAssertTrue((result.points == 9), @"result.pointPercentage %d should == 9",result.points);
    
    XCTAssertTrue((result.pointsPossible == 9), @"result.pointsPossible %d should == 9",result.pointsPossible);
}

- (void)test_MultiMultiChoiceQuestion_MultipleSelectableOptions_incorrect
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test_multiple_multi_multi_choice.plist"];
    
    ISSession* session = [ISSession session];
    
    [session setResponse:[ISMultipleChoiceResponse responseWithIndexes:@[ @[@1] , @[@1] , @[@1] ]] atIndex:0];
    
    [session setResponse:[ISMultipleChoiceResponse responseWithIndexes:@[ @[@1,@2] , @[@1,@2] , @[@1,@2] ]] atIndex:1];
    
    ISGradingResult* result = [quiz gradeSession:session];
    
    XCTAssertTrue((result.pointPercentage == 0.00f), @"result.pointPercentage %f should == 0.00",result.pointPercentage);
    
    XCTAssertTrue((result.points == 0), @"result.pointPercentage %d should == 0",result.points);
    
    XCTAssertTrue((result.pointsPossible == 9), @"result.pointsPossible %d should == 9",result.pointsPossible);
}

/*
 Testing that the Sentence Layout MultiMultiChoice questions deserialize corectly
 */

- (void)testQuizSessionGradeSentenceMultiMultiChoiceQuestionCorrect
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"quiz_test_sentence_multi_multi_choice.plist"];
    
    XCTAssertTrue(([quiz.questions[0] isKindOfClass:[ISMultipleMultipleChoiceQuestion class]]),@"not correct class");
    
    ISSession* session = [ISSession session];
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@3] , @[@0] , @[@4] ]];
    
    [session setResponse:response atIndex:0];
    
    ISGradingResult* result = [quiz gradeSession:session];
    
    XCTAssertTrue((result.pointPercentage == 1.00f), @"result.pointPercentage %f should == 1.00",result.pointPercentage);
    
    XCTAssertTrue((result.points == 3), @"result.pointPercentage %d should == 3",result.points);
    
    XCTAssertTrue((result.pointsPossible == 3), @"result.pointsPossible %d should == 3",result.pointsPossible);
}

#pragma mark - selctable options
/*
 Should test that when selctable options in question plist is 0 or nil selctableOptions should equal number of correct answers
 */
- (void)testSelectableOptionsDefault
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"default_selectable_options.plist"];
    
    XCTAssertTrue(([quiz.questions[0] isKindOfClass:[ISMultipleChoiceQuestion class]]),@"not correct class");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @3 , @0 , @4 ]];
    
    ISMultipleChoiceQuestion* question = quiz.questions[0];
    
    XCTAssertTrue((question.selectableOptions.intValue == 2),@"selectableOptions incorrect");
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
    
}

- (void)testSelectableOptionsDefaultIncorrectOneSelection
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"default_selectable_options.plist"];
    
    XCTAssertTrue(([quiz.questions[0] isKindOfClass:[ISMultipleChoiceQuestion class]]),@"not correct class");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @0 ]];
    
    ISMultipleChoiceQuestion* question = quiz.questions[0];
    
     XCTAssertTrue((question.selectableOptions.intValue == 2),@"selectableOptions incorrect");
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be incorrect");
    
}

- (void)testSelectableOptionsDefaultCorrect
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"default_selectable_options.plist"];
    
    XCTAssertTrue(([quiz.questions[0] isKindOfClass:[ISMultipleChoiceQuestion class]]),@"not correct class");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @0 , @2 ]];
    
    ISMultipleChoiceQuestion* question = quiz.questions[0];
    
    XCTAssertTrue((question.selectableOptions.intValue == 2),@"selectableOptions incorrect");
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
    
}

- (void)testSentenceMMCSelectableOptionsDefaultCorrect
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"default_selectable_options.plist"];
    
    XCTAssertTrue(([quiz.questions[1] isKindOfClass:[ISMultipleMultipleChoiceQuestion class]]),@"not correct class");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@3] , @[@0] , @[@4] ]];
    
    ISMultipleChoiceQuestion* question = quiz.questions[1];
    
    XCTAssertTrue((question.selectableOptions.intValue == 1),@"selectableOptions: %d incorrect",question.selectableOptions.intValue);
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertTrue(correct, @"answer should be correct");
    
    
}

- (void)testSentenceMMCSelectableOptionsDefaultCorrectPartialAnswer
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"default_selectable_options.plist"];
    
    XCTAssertTrue(([quiz.questions[1] isKindOfClass:[ISMultipleMultipleChoiceQuestion class]]),@"not correct class");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@0] ]];
    
    ISMultipleChoiceQuestion* question = quiz.questions[1];
    
    XCTAssertTrue((question.selectableOptions.intValue == 1),@"selectableOptions: %d incorrect",question.selectableOptions.intValue);
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be correct");
    
    
}

- (void)testSentenceMMCSelectableOptionsDefaultIncorrectPartialAnswer
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"default_selectable_options.plist"];
    
    XCTAssertTrue(([quiz.questions[1] isKindOfClass:[ISMultipleMultipleChoiceQuestion class]]),@"not correct class");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@2] ]];
    
    ISMultipleChoiceQuestion* question = quiz.questions[1];
    
    XCTAssertTrue((question.selectableOptions.intValue == 1),@"selectableOptions: %d incorrect",question.selectableOptions.intValue);
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be correct");
    
    
}

- (void)testSentenceMMCSelectableOptionsDefaultIncorrect
{
    ISQuiz* quiz = [ISQuizParser quizNamed:@"default_selectable_options.plist"];
    
    XCTAssertTrue(([quiz.questions[1] isKindOfClass:[ISMultipleMultipleChoiceQuestion class]]),@"not correct class");
    
    ISMultipleChoiceResponse* response = [ISMultipleChoiceResponse responseWithIndexes:@[ @[@2] , @[@1] , @[@3] ]];
    
    ISMultipleChoiceQuestion* question = quiz.questions[1];
    
    XCTAssertTrue((question.selectableOptions.intValue == 1),@"selectableOptions: %d incorrect",question.selectableOptions.intValue);
    
    BOOL correct = [question responseCorrect:response];
    
    XCTAssertFalse(correct, @"answer should be correct");
    
    
}

@end
