//
//  ISMultipleChoiceQuestionTests.m
//  iOS-QuizKit
//
//  Created by Christian French on 12/09/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ISMultipleChoiceQuestion.h"
#import "ISMultipleChoiceQuestion+Private.h"
@interface ISMultipleChoiceQuestionTests : XCTestCase

@end

@implementation ISMultipleChoiceQuestionTests

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

- (void)testRandomizeMap
{
    ISMultipleChoiceQuestion* question = [ISMultipleChoiceQuestion new];
    
    ISMultipleChoiceOption* option1 = [ISMultipleChoiceOption optionWithText:@"One" correct:YES];
    
    ISMultipleChoiceOption* option2 = [ISMultipleChoiceOption optionWithText:@"Two" correct:YES];
    
    ISMultipleChoiceOption* option3 = [ISMultipleChoiceOption optionWithText:@"Three" correct:YES];
    
    ISMultipleChoiceOption* option4 = [ISMultipleChoiceOption optionWithText:@"Four" correct:YES];
    
    ISMultipleChoiceOption* option5 = [ISMultipleChoiceOption optionWithText:@"Five" correct:NO];
    
    ISMultipleChoiceOption* option6 = [ISMultipleChoiceOption optionWithText:@"Six" correct:NO];
    
    ISMultipleChoiceOption* option7 = [ISMultipleChoiceOption optionWithText:@"Seven" correct:NO];
    
    ISMultipleChoiceOption* option8 = [ISMultipleChoiceOption optionWithText:@"Eight" correct:NO];
    
    [question addOptions:@[option1,option2,option3,option4,option5,option6,option7,option8]];
    
    NSInteger i = 0;
    
    for(NSNumber* origialIndex in question.randomizedIndexesMap) {
        
        XCTAssertTrue((question.randomizedOptions[i] == question.options[origialIndex.intValue]), @"objects should match");
        
        i++;
    }
    
}

@end
