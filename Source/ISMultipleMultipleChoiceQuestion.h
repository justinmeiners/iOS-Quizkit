//
//  ISMultipleMultipleChoiceQuestion.h
//  iOS-QuizKit
//
//  Created by Christian French on 30/04/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import "ISQuestion.h"
#import "ISMultipleChoiceQuestion.h"

@interface ISMultipleMultipleChoiceQuestion : ISMultipleChoiceQuestion


+ (instancetype)questionWithQuestions:(NSArray*)questions;

- (id)initWithQuestions:(NSArray*)questions;

- (void)addQuestion:(ISMultipleChoiceQuestion*)question;

@end
