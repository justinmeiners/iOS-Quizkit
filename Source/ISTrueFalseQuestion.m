/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "ISTrueFalseQuestion.h"

static NSString * const _ISAnswerKey = @"answer";
static NSString * const _ISResponseKey = @"response";

@implementation ISTrueFalseResponse
@synthesize response = _response;

+ (ISTrueFalseResponse*)responseWithResponse:(BOOL)response
{
    return [[self alloc] initWithResponse:response];
}

- (id)initWithResponse:(BOOL)response
{
    if (self = [super init])
    {
        self.response = response;
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.response = [aDecoder decodeBoolForKey:_ISResponseKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:_response forKey:_ISAnswerKey];
}


@end

@implementation ISTrueFalseQuestion
@synthesize answer = _answer;

- (id)init
{
    if (self = [super init])
    {
        _answer = true;
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.answer = [aDecoder decodeBoolForKey:_ISAnswerKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeBool:_answer forKey:_ISAnswerKey];
}

- (BOOL)responseCorrect:(ISQuestionResponse*)response
{
    if (![response isKindOfClass:[ISTrueFalseResponse class]])
    {
        return NO;
    }
    
    ISTrueFalseResponse* casted = (ISTrueFalseResponse*)response;
    
    return (casted.response == _answer);
}

@end
