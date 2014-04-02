/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "ISQuizParser.h"
#import "ISOpenQuestion.h"
#import "ISMultipleChoiceQuestion.h"
#import "ISTrueFalseQuestion.h"

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
            
            if (questionDict[kISAnswerKey])
            {
                [question addAnswer:questionDict[kISAnswerKey]];
            }
            else if (questionDict[kISAnswersKey])
            {
                [question addAnswers:questionDict[kISAnswersKey]];
            }
            else
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
                else
                {
                    NSLog(@"unknown match mode: %@", matchMode);
                    return nil;
                }
            }
            
            [quiz addQuestion:question];
            
            newQuestion = question;
        }
        else if ([type isEqualToString:kISQuestionTypeMultipleChoice])
        {
            ISMultipleChoiceQuestion* question = [[ISMultipleChoiceQuestion alloc] init];
        
            NSArray* options = questionDict[kISOptionsKey];
            
            if (![self verify:options class:[NSArray class]])
            {
                NSLog(@"missing multiple choice options");
                return nil;
            }
            
            for (NSDictionary* optionDict in options)
            {
                ISMultipleChoiceOption* option = [[ISMultipleChoiceOption alloc] init];
                option.text = optionDict[kISTextKey];
                
                if (optionDict[kISCorrectKey])
                {
                    option.correct = [optionDict[kISCorrectKey] boolValue];
                }
                else
                {
                    option.correct = false;
                }
                
                [question addOption:option];
            }
            
            [quiz addQuestion:question];
            
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
            [quiz addQuestion:question];
            
            newQuestion = question;
        }
        else
        {
            NSLog(@"unknown question type: %@", type);
            continue;
        }
               
        newQuestion.text = questionDict[kISTextKey];
        
        if (questionDict[kISScoreValueKey])
        {
            newQuestion.scoreValue = [questionDict[kISScoreValueKey] intValue];
        }
    }
    
    return quiz;
}

@end
