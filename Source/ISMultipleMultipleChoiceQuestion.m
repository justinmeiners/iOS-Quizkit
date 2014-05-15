//
//  ISMultipleMultipleChoiceQuestion.m
//  iOS-QuizKit
//
//  Created by Christian French on 30/04/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import "ISMultipleMultipleChoiceQuestion.h"

#import "ISMultipleMultipleChoiceQuestion+Private.h"

@implementation ISMultipleMultipleChoiceQuestion

+ (instancetype)questionWithQuestions:(NSArray*)questions {
    
    return [[ISMultipleMultipleChoiceQuestion alloc] initWithQuestions:questions];
}

- (id)initWithQuestions:(NSArray*)questions {
    
    if(self = [super init]) {
        
        NSMutableArray* options = [NSMutableArray array];
        
        for (ISMultipleChoiceQuestion* question in questions) {
            
            [options addObject:question.options];
        }
        
        self.options = [NSArray arrayWithArray:options];
        
        _questions = questions;
        
    }
    return self;
}

- (NSArray *)options {
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (ISMultipleChoiceQuestion* question in _questions) {
        
        [array addObject:question.options];
    }
    return [NSArray arrayWithArray:array];
}

- (BOOL)responseCorrect:(ISQuestionResponse*)response {
    
    if (![response isKindOfClass:[ISMultipleChoiceResponse class]])
    {
        return NO;
    }
    
    ISMultipleChoiceResponse* multipleChoiceResponse = (ISMultipleChoiceResponse*)response;
    
    BOOL correct = YES;
    
    for (ISMultipleChoiceQuestion* question in _questions) {
        
        NSUInteger idx = [_questions indexOfObject:question];
        
        NSArray* answerIndexes = multipleChoiceResponse.answerIndexes[idx];
        
        correct = [question responseCorrect: [ISMultipleChoiceResponse responseWithIndexes:answerIndexes]];
        
        if(!correct) {
            
            break;
        }
    }
    
    return correct;
}

- (void)addQuestion:(ISMultipleChoiceQuestion*)question {

    if(!_questions) {
        
        _questions = @[];
    }
    
    _questions = [_questions arrayByAddingObject:question];
    
}

@end
