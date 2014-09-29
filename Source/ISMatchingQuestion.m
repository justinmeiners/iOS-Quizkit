//
//  ISMatchingQuestion.m
//  iOS-QuizKit
//
//  Created by Christian French on 17/06/2014.
//  Copyright (c) 2014 inline-studios. All rights reserved.
//

#import "ISMatchingQuestion.h"
#import "ISMultipleChoiceQuestion+Private.h"

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

- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p, text: %@ >",
            NSStringFromClass([self class]), self, _text];
}

@end

@implementation ISMatchingQuestion


+ (instancetype)questionWithOptions:(NSArray*)options answers:(NSArray*)answers {
    
    ISMatchingQuestion* question = [[ISMatchingQuestion alloc] init];
    
    question.answers = answers;
    
    question.options = options;
    
    [question randomizeAnswers];
    
    return question;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _options = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:_ISMatchingOptionsKey]];
        _answers = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:_ISMatchingAnswersKey]];
        [self randomizeAnswers];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_options forKey:_ISMatchingOptionsKey];
    [aCoder encodeObject:_answers forKey:_ISMatchingAnswersKey];
}

-(void)randomizeAnswers {
    
    NSMutableArray* options = [NSMutableArray arrayWithArray:_answers];
    
    NSMutableArray* randomOptions = [NSMutableArray array];
    
    while (options.count > 0) {
        
        NSInteger randomNumber = arc4random() % options.count;
        
        id option = options[randomNumber];
        
        [randomOptions addObject:option];
        
        [options removeObject:option];
    }
    
    _randomizedAnswers = [NSArray arrayWithArray:randomOptions];
}

- (BOOL)responseCorrect:(ISQuestionResponse*)response
{
    if (![response isKindOfClass:[ISMatchingResponse class]])
    {
        return NO;
    }
    
    ISMatchingResponse* matchingResponse = (ISMatchingResponse*)response;
    
    __block BOOL correct = YES;
    
    if(matchingResponse.options.count != _options.count) {
    
        return NO;
    
    }
    
    [_options enumerateObjectsUsingBlock:^(ISMatchingOption* obj, NSUInteger idx, BOOL *stop) {
        
        if(matchingResponse.options[idx] != obj.matchingOption){
            
            correct = NO;
            
            *stop = YES;
        }
    }];
    
    return correct;
}

@end