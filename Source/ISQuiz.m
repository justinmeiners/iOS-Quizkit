/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import "ISQuiz.h"

static NSString * const _ISQuestionsKey = @"questions";
static NSString * const _ISTimeLimitKey = @"timeLimit";


@implementation ISQuiz
@synthesize questions = _questions;
@synthesize timeLimit = _timeLimit;


- (id)init
{
    if (self = [super init])
    {
        _questions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_questions release];
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        _questions = [[NSMutableArray alloc] init];
        [_questions addObjectsFromArray:[decoder decodeObjectForKey:_ISQuestionsKey]];
        
        _timeLimit = [decoder decodeDoubleForKey:_ISTimeLimitKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_questions forKey:_ISQuestionsKey];
    [coder encodeDouble:_timeLimit forKey:_ISTimeLimitKey];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p, questions: %@>",
            NSStringFromClass([self class]), self, _questions];
}

- (void)addQuestion:(ISQuestion*)question
{
    [_questions addObject:question];
}

- (void)removeQuestion:(ISQuestion*)question
{
    [_questions removeObject:question];
}

- (void)removeAllQuestions
{
    [_questions removeAllObjects];
}


@end
