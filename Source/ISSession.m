/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import "ISSession.h"

@implementation ISSession
@synthesize startDate = _startDate;
@synthesize responses = _responses;
@synthesize userData = _userData;

- (id)initWithQuiz:(ISQuiz*)quiz
{
    if (self = [super init])
    {
        _responses = [[NSMutableArray arrayWithCapacity:quiz.questions.count] retain];
        
        for (int i = 0; i < quiz.questions.count; i ++)
        {
            ISEmptyQuestionResponse* emptyResponse = [[ISEmptyQuestionResponse alloc] init];
            [_responses addObject:emptyResponse];
            [emptyResponse release];
        }
    }
    return self;
}

- (void)dealloc
{
    [_responses release];
    [super dealloc];
}

- (void)setResponse:(ISQuestionResponse*)response
            atIndex:(int)index
{
    [_responses replaceObjectAtIndex:index withObject:response];
}

- (void)clearResponseAtIndex:(int)index
{
    [_responses replaceObjectAtIndex:index withObject:[ISEmptyQuestionResponse emptyResponse]];
}

- (BOOL)complete
{
}

@end
