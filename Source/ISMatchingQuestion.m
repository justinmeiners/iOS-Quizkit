//
//  ISMatchingQuestion.m
//  iOS-QuizKit
//
//  Created by Christian French on 17/06/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import "ISMatchingQuestion.h"

static NSString * const _ISAnswerOptionsKey = @"answerOptions";

static NSString * const _ISMatchingOptionsKey = @"MatchingOptions";

static NSString * const _ISMatchingAnswersKey = @"MatchingAnswers";

static NSString * const _ISMatchingOptionKey = @"MatchingOption";

@implementation ISMatchingResponse

+ (ISMatchingResponse*)responseWithOptions:(NSArray*)options {
    
    ISMatchingResponse* response = [ISMatchingResponse new];
    
    response.options = options;
    
    return response;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.options = [aDecoder decodeObjectForKey:_ISAnswerOptionsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_options forKey:_ISAnswerOptionsKey];
}

@end

@implementation ISMatchingOption

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.text = [aDecoder decodeObjectForKey:_ISTextKey];
        self.matchingOption = [aDecoder decodeObjectForKey:_ISMatchingOptionKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_text forKey:_ISTextKey];
    [aCoder encodeObject:_matchingOption forKey:_ISMatchingOptionKey];
}

+ (ISMatchingOption*)optionWithText:(NSString*)text {

    return [ISMatchingOption optionWithText:text matchingOption:nil];
}

+ (ISMatchingOption*)optionWithText:(NSString*)text matchingOption:(ISMatchingOption*)matchingOption {
    
    ISMatchingOption* option = [ISMatchingOption new];
    
    option.text = text;
    
    option.matchingOption = matchingOption;
    
    return option;
}

@end

@implementation ISMatchingQuestion


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _options = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:_ISMatchingOptionsKey]];
        _answers = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:_ISMatchingAnswersKey]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_options forKey:_ISMatchingOptionsKey];
    [aCoder encodeObject:_answers forKey:_ISMatchingAnswersKey];
}

- (BOOL)responseCorrect:(ISQuestionResponse*)response
{
    if (![response isKindOfClass:[ISMatchingResponse class]])
    {
        return NO;
    }
    
    ISMatchingResponse* matchingResponse = (ISMatchingResponse*)response;
    
    __block BOOL correct = YES;
    
    [_options enumerateObjectsUsingBlock:^(ISMatchingOption* obj, NSUInteger idx, BOOL *stop) {
        
        if(matchingResponse.options[idx] != obj.matchingOption){
            
            correct = NO;
            
            *stop = YES;
        }
    }];
    
    return correct;
}

@end