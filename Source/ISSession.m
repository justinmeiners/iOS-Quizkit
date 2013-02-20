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
@synthesize inSession = _inSession;
@synthesize paused = _paused;
@synthesize delegate = _delegate;

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

- (id)init
{
    if (self = [super init])
    {
        _responses = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_responses release];
    [super dealloc];
}

- (BOOL)start:(ISQuiz*)quiz
{
    self.startDate = [NSDate date];
    
    if (_responses.count == 0)
    {
        for (int i = 0; i < quiz.questions.count; i ++)
        {
            ISEmptyQuestionResponse* emptyResponse = [[ISEmptyQuestionResponse alloc] init];
            [_responses addObject:emptyResponse];
            [emptyResponse release];
        }
    }
    else
    {
        if (_responses.count != quiz.questions.count)
        {
            NSLog(@"resuming session with incorrect quiz");
            return NO;
        }
    }
    

    _inSession = true;
    _paused = false;
    
    if (_delegate && [_delegate respondsToSelector:@selector(sessionStarted:)])
    {
        [_delegate sessionStarted:self];
    }
    
    return YES;
}

- (void)setPaused:(BOOL)paused
{
    _paused = paused;
}

- (void)finish
{
    if (!_inSession)
    {
        NSLog(@"ISSession finish when not in session");
        return;
    }
    
    _paused = false;
    _inSession = false;
    
    if (_delegate && [_delegate respondsToSelector:@selector(sessionFinished:)])
    {
        [_delegate sessionFinished:self];
    }
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
