/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import "ISSession.h"

static NSString * const _ISUserDataKey = @"userData";
static NSString * const _ISStartDateKey = @"startDate";
static NSString * const _ISResponsesKey = @"responses";

@implementation ISSession
@synthesize startDate = _startDate;
@synthesize responses = _responses;
@synthesize userData = _userData;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        _responses = [[NSMutableArray alloc] init];
        [_responses addObjectsFromArray:[aDecoder decodeObjectForKey:_ISResponsesKey]];
        self.startDate = [aDecoder decodeObjectForKey:_ISStartDateKey];
        self.userData = [aDecoder decodeObjectForKey:_ISUserDataKey];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_responses forKey:_ISResponsesKey];
    [aCoder encodeObject:_startDate forKey:_ISStartDateKey];
    [aCoder encodeObject:_userData forKey:_ISUserDataKey];
}

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
