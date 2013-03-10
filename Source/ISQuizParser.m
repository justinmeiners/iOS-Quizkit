/*
 Copyright (c) 2012 Inline Studios
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
    NSString* fullpath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    
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

    return [self quizFromDictionary:[plist autorelease]];
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
    NSArray* questions = [dictionary objectForKey:kISQuestionsKey];
    
    if (![self verify:questions class:[NSArray class]])
    {
        NSLog(@"missing questions");
        return nil;
    }

    ISQuiz* quiz = [[ISQuiz alloc] init];
    
    for (NSDictionary* questionDict in questions)
    {
        NSString* type = [questionDict objectForKey:kISTypeKey];
        
        ISQuestion* newQuestion = nil;
        
        if ([type isEqualToString:kISQuestionTypeOpen])
        {
            ISOpenQuestion* question = [[ISOpenQuestion alloc] init];
            
            if ([questionDict objectForKey:kISAnswerKey])
            {
                [question addAnswer:[questionDict objectForKey:kISAnswerKey]];
            }
            else if ([questionDict objectForKey:kISAnswersKey])
            {
                [question addAnswers:[questionDict objectForKey:kISAnswersKey]];
            }
            else
            {
                [quiz release];
                [question release];
                NSLog(@"missing question answer");
                return nil;
            }
            
            NSString* matchMode = [questionDict objectForKey:kISMatchModeKey];
            
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
            [question release];
            
            newQuestion = question;
        }
        else if ([type isEqualToString:kISQuestionTypeMultipleChoice])
        {
            ISMultipleChoiceQuestion* question = [[ISMultipleChoiceQuestion alloc] init];
        
            NSArray* options = [questionDict objectForKey:kISOptionsKey];
            
            if (![self verify:options class:[NSArray class]])
            {
                [question release];
                NSLog(@"missing multiple choice options");
                return nil;
            }
            
            for (NSDictionary* optionDict in options)
            {
                ISMultipleChoiceOption* option = [[ISMultipleChoiceOption alloc] init];
                option.text = [optionDict objectForKey:kISTextKey];
                
                if ([optionDict objectForKey:kISCorrectKey])
                {
                    option.correct = [[optionDict objectForKey:kISCorrectKey] boolValue];
                }
                else
                {
                    option.correct = false;
                }
                
                [question addOption:option];
                [option release];
            }
            
            [quiz addQuestion:question];
            [question release];
            
            newQuestion = question;
        }
        else if ([type isEqualToString:kISQuestionTypeTrueFalse])
        {
            ISTrueFalseQuestion* question = [[ISTrueFalseQuestion alloc] init];
            
            if (![self verify:[questionDict objectForKey:kISAnswerKey] class:[NSNumber class]])
            {
                [question release];
                NSLog(@"missing annswer");
                return nil;
            }
            
            question.answer = [[questionDict objectForKey:kISAnswerKey] boolValue];
            [quiz addQuestion:question];
            [question release];
            
            newQuestion = question;
        }
        else
        {
            NSLog(@"unknown question type: %@", type);
            continue;
        }
               
        newQuestion.text = [questionDict objectForKey:kISTextKey];
        
        if ([questionDict objectForKey:kISScoreValueKey])
        {
            newQuestion.scoreValue = [[questionDict objectForKey:kISScoreValueKey] intValue];
        }
    }
    
    return [quiz autorelease];
}

@end
