/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "ISQuizParser.h"
#import "ISOpenQuestion.h"
#import "ISMultipleChoiceQuestion.h"
#import "ISTrueFalseQuestion.h"
#import "ISMultipleMultipleChoiceQuestion.h"
#import "ISMatchingQuestion.h"
@implementation ISQuizParser

+ (ISQuiz*)quizNamed:(NSString*)name
{
    NSString* extension = [[name pathExtension] lowercaseString];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString* fullpath = [bundle pathForResource:name ofType:nil];
    
    if ([extension isEqualToString:@"plist"])
    {
        return [self quizFromContentsOfPlist:fullpath];
    }
    else if ([extension isEqualToString:@"json"])
    {
        return [self quizFromContentsOfJSON:fullpath];
    }
    else
    {
        return [self quizWithContentsOfFile:fullpath];
    }
}

+ (ISQuiz*)quizWithContentsOfFile:(NSString*)file
{
    NSData* data = [NSData dataWithContentsOfFile:file];
    
    if (!data)
    {
        return nil;
    }
    
    ISQuiz* quiz = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (![quiz isKindOfClass:[ISQuiz class]])
    {
        return nil;
    }
    
    return quiz;
}


+ (ISQuiz*)quizFromContentsOfPlist:(NSString*)file
{
    NSDictionary* plist = [[NSDictionary alloc] initWithContentsOfFile:file];
    
    return [self quizFromDictionary:plist];
}

+ (ISQuiz*)quizFromContentsOfJSON:(NSString*)jsonFile
{
    NSData* data = [NSData dataWithContentsOfFile:jsonFile];
    
    if (!data)
    {
        return nil;
    }
    
    NSError* error = nil;
    
    NSDictionary* plist = [NSJSONSerialization JSONObjectWithData:data
                                                          options:0
                                                            error:&error];
    
    if (error)
    {
        NSLog(@"quiz json error: %@", [error description]);
        return nil;
    }

    return [self quizFromDictionary:plist];
}

+ (BOOL)verify:(id <NSObject>)object class:(Class)class
{
    if (!object)
    {
        return false;
    }
    
    return [object isKindOfClass:class];
}

+ (ISQuiz*)quizFromDictionary:(NSDictionary*)dictionary
{
    NSArray* questions = dictionary[kISQuestionsKey];
    
    if (![self verify:questions class:[NSArray class]])
    {
        NSLog(@"missing questions");
        return nil;
    }

    ISQuiz* quiz = [[ISQuiz alloc] init];
    
    for (NSDictionary* questionDict in questions)
    {
        NSString* type = questionDict[kISTypeKey];
        
        ISQuestion* newQuestion = nil;
        
        if ([type isEqualToString:kISQuestionTypeOpen])
        {
            ISOpenQuestion* question = [[ISOpenQuestion alloc] init];
            
            question.options = questionDict[kISOptionsKey];
            
            if (questionDict[kISAnswerKey])
            {
                [question addAnswer:questionDict[kISAnswerKey]];
            }
            else if (questionDict[kISAnswersKey])
            {
                [question addAnswers:questionDict[kISAnswersKey]];
            }
            else // if contain options parse to answers
            {
                NSLog(@"missing question answer");
                return nil;
            }
            
            NSString* matchMode = questionDict[kISMatchModeKey];
            
            if (matchMode)
            {
                if ([matchMode isEqualToString:@"close"])
                {
                    question.matchMode = kISOpenQuestionMatchModeClose;
                }
                else if ([matchMode isEqualToString:@"exact"])
                {
                    question.matchMode = kISOpenQuestionMatchModeExact;
                }
                else if ([matchMode isEqualToString:@"caseSensitive"])
                {
                    question.matchMode = kISOpenQuestionMatchModeCaseSensitive;
                }
                else if ([matchMode isEqualToString:@"contains"])
                {
                    question.matchMode = kISOpenQuestionContainsAll;
                }
                else
                {
                    NSLog(@"unknown match mode: %@", matchMode);
                    return nil;
                }
            }
            
            newQuestion = question;
        }
        else if ([type isEqualToString:kISQuestionTypeMultipleChoice])
        {
            ISMultipleChoiceQuestion* question = [[ISMultipleChoiceQuestion alloc] init];
        
            if(questionDict[kISSelectableOptionsKey]) {
            
                question.selectableOptions = questionDict[kISSelectableOptionsKey];
                
            }
            
            NSArray* options = questionDict[kISOptionsKey];
            
            if (![self verify:options class:[NSArray class]])
            {
                NSLog(@"missing multiple choice options");
                return nil;
            }
            
            NSInteger correctCount = 0;
            
            for (NSDictionary* optionDict in options)
            {
                ISMultipleChoiceOption* option = [[ISMultipleChoiceOption alloc] init];
                option.text = optionDict[kISTextKey];
                option.preSelected = [optionDict[kISPreSelectedKey] boolValue];
                if (optionDict[kISCorrectKey])
                {
                    option.correct = [optionDict[kISCorrectKey] boolValue];
                    
                    if(option.correct) {
                        
                        correctCount++;
                    }
                }
                else
                {
                    option.correct = false;
                }
                
                [question addOption:option];
            }
            
            if(question.selectableOptions.integerValue == 0) {
                
                question.selectableOptions = [NSNumber numberWithInteger:correctCount];
            }
            
            newQuestion = question;
        }
        else if ([type isEqualToString:kISQuestionTypeMultipleMultipleChoice])
        {
            ISMultipleMultipleChoiceQuestion* question = [[ISMultipleMultipleChoiceQuestion alloc] init];
            
            if(questionDict[kISSelectableOptionsKey]) {
                
                question.selectableOptions = questionDict[kISSelectableOptionsKey];
                
            }
            
            question.supplementaryText = questionDict[kISupplementaryTextKey];
            
            NSArray* options = questionDict[kISOptionsKey];
            
            if (![self verify:options class:[NSArray class]])
            {
                NSLog(@"missing multiple choice options");
                return nil;
            }
            
            for (NSArray* section in options) {
            
                ISMultipleChoiceQuestion* multipleChoiceQuestion = [[ISMultipleChoiceQuestion alloc] init];
                
                multipleChoiceQuestion.selectableOptions = question.selectableOptions;
                
                NSInteger correctCount = 0;
                
                for (NSDictionary* optionDict in section)
                {
                    ISMultipleChoiceOption* option = [[ISMultipleChoiceOption alloc] init];
                    option.text = optionDict[kISTextKey];
                    option.preSelected = [optionDict[kISPreSelectedKey] boolValue];
                    if (optionDict[kISCorrectKey])
                    {
                        option.correct = [optionDict[kISCorrectKey] boolValue];
                        
                        if(option.correct) {
                            
                            correctCount++;
                        }
                    }
                    else
                    {
                        option.correct = false;
                    }
                    
                    [multipleChoiceQuestion addOption:option];
                }
                
                if(question.selectableOptions.integerValue == 0) {
                    
                    question.selectableOptions = [NSNumber numberWithInteger:correctCount];
                }

                
                [question addQuestion:multipleChoiceQuestion];
                
            }
            
            newQuestion = question;
        }
        else if ([type isEqualToString:kISQuestionTypeMultipleMultipleChoiceSentence])
        {
            ISMultipleMultipleChoiceQuestion* question = [[ISMultipleMultipleChoiceQuestion alloc] init];
            
            if(questionDict[kISSelectableOptionsKey]) {
                
                question.selectableOptions = questionDict[kISSelectableOptionsKey];
                
            }
            
            NSArray* options = questionDict[kISOptionsKey];
            
            if (![self verify:options class:[NSArray class]])
            {
                NSLog(@"missing multiple choice options");
                return nil;
            }
            
            for (NSDictionary* option in options) {
                
                NSString* optionText = option[kISTextKey];
                
                NSArray* optionWords = [optionText componentsSeparatedByString:@" "];
                
                NSString* correctText = option[kISCorrectKey];
                
                NSArray* correctWordIndexes = [correctText componentsSeparatedByString:@" "];
                
                ISMultipleChoiceQuestion* multipleChoiceQuestion = [[ISMultipleChoiceQuestion alloc] init];
                
                multipleChoiceQuestion.selectableOptions = question.selectableOptions;
                
                NSInteger correctCount = 0;
                
                for (NSString* word in optionWords)
                {
                    ISMultipleChoiceOption* option = [[ISMultipleChoiceOption alloc] init];
                    
                    option.text = word;
                    
                    NSInteger currentIndex = [optionWords indexOfObjectIdenticalTo:word];
                    
                    NSUInteger index = [correctWordIndexes indexOfObjectPassingTest:^BOOL(NSString* obj, NSUInteger idx, BOOL *stop) {
                        
                        NSInteger correctIndex = [obj integerValue];
                        
                        if(currentIndex == correctIndex){
                            *stop = YES;
                            return YES;
                        }
                        
                        return NO;
                    }];
                    
                    if(index != NSNotFound) {
                        
                        option.correct = YES;
                        
                        correctCount++;
                        
                    }
                    
                    [multipleChoiceQuestion addOption:option];
                }
                
                if(question.selectableOptions.integerValue == 0) {
                    
                    multipleChoiceQuestion.selectableOptions = [NSNumber numberWithInteger:correctCount];
                }
                
                //for the moment this doesnt do anything, just for consistancy
                question.selectableOptions = [NSNumber numberWithInteger:correctCount];
                
                [question addQuestion:multipleChoiceQuestion];
                
            }

            newQuestion = question;
        }
        else if ([type isEqualToString:kISQuestionTypeTrueFalse])
        {
            ISTrueFalseQuestion* question = [[ISTrueFalseQuestion alloc] init];
            
            if (![self verify:questionDict[kISAnswerKey] class:[NSNumber class]])
            {
                NSLog(@"missing annswer");
                return nil;
            }
            
            question.answer = [questionDict[kISAnswerKey] boolValue];
            
            
            newQuestion = question;
        }
        else if  ([type isEqualToString:kISQuestionTypeMatching])
        {
            
            
            NSArray* answers = questionDict[kISAnswersKey];
            
            NSMutableArray* questionAnswers = [NSMutableArray array];
            
            if (![self verify:answers class:[NSArray class]])
            {
                NSLog(@"missing answers");
                return nil;
            }
            
            for (NSDictionary* answer in answers) {
                
                NSString* optionText = answer[kISTextKey];
                
                [questionAnswers addObject:[ISMatchingOption optionWithText:optionText]];
            }
            
           
            
            NSArray* options = questionDict[kISOptionsKey];
            
            NSMutableArray* questionOptions = [NSMutableArray array];
            
            if (![self verify:options class:[NSArray class]])
            {
                NSLog(@"missing options");
                return nil;
            }
            
            for (NSDictionary* option in options) {
                
                NSString* optionText = option[kISTextKey];
                
                NSNumber* answerIndex = option[kISCorrectKey];
                
                [questionOptions addObject:[ISMatchingOption optionWithText:optionText matchingOption:questionAnswers[answerIndex.integerValue]]];
            }
            
            ISMatchingQuestion* question = [ISMatchingQuestion questionWithOptions:questionOptions answers:questionAnswers];
            
            newQuestion = question;
            
        }
        else
        {
            NSLog(@"unknown question type: %@", type);
            continue;
        }
               
        newQuestion.text = questionDict[kISTextKey];
        
        newQuestion.supplementaryText = questionDict[kISupplementaryTextKey];
        
        newQuestion.questionType = type;
        
        newQuestion.questionSubType = questionDict[kISSubTypeKey];
        
        if (questionDict[kISScoreValueKey])
        {
            newQuestion.scoreValue = [questionDict[kISScoreValueKey] intValue];
        }
        
        [quiz addQuestion:newQuestion];
    }
    
    return quiz;
}

@end
