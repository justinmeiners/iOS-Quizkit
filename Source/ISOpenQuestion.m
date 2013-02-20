/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "ISOpenQuestion.h"

static NSString * const _ISResponseKey = @"response";
static NSString * const _ISAnswersKey = @"answers";
static NSString * const _ISMatchModeKey = @"matchMode";

@implementation ISOpenQuestionResponse
@synthesize response = _response;

+ (ISOpenQuestionResponse*)responseWithResponse:(NSString*)response
{
    return [[[self alloc] initWithResponse:response] autorelease];
}

- (id)init
{
    if (self = [super init])
    {
        self.response = nil;
    }
    return self;
}

- (void)dealloc
{
    self.response = nil;
    [super dealloc];
}

- (id)initWithResponse:(NSString*)response
{
    if (self = [super init])
    {
        self.response = response;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.response = [aDecoder decodeObjectForKey:_ISResponseKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_response forKey:_ISResponseKey];
}

@end

static const ISMatchFunc_t _ISExactMatchFunc = ^BOOL(NSString *answer, NSString *response) {
    return [[answer lowercaseString] isEqualToString:[response lowercaseString]];
};

static const ISMatchFunc_t _ISCaseSensitiveMatchFunc = ^BOOL(NSString *answer, NSString *response) {
    return [answer isEqualToString:response];
};

static const ISMatchFunc_t _ISCloseMatchFunc = ^BOOL(NSString *answer, NSString *response) {
    
    answer = [answer lowercaseString];
    response = [response lowercaseString];
    
    NSUInteger sl = [answer length];
    NSUInteger tl = [response length];
    NSUInteger *d = calloc(sizeof(*d), (sl+1) * (tl+1));
    
#define d(i, j) d[((j) * sl) + (i)]
    for (NSUInteger i = 0; i <= sl; i++) {
        d(i, 0) = i;
    }
    for (NSUInteger j = 0; j <= tl; j++) {
        d(0, j) = j;
    }
    for (NSUInteger j = 1; j <= tl; j++) {
        for (NSUInteger i = 1; i <= sl; i++) {
            if ([answer characterAtIndex:i-1] == [response characterAtIndex:j-1]) {
                d(i, j) = d(i-1, j-1);
            } else {
                d(i, j) = MIN(d(i-1, j), MIN(d(i, j-1), d(i-1, j-1))) + 1;
            }
        }
    }
    
    NSUInteger r = d(sl, tl);
#undef d
    
    free(d);
    
    if (r <= 3)
    {
        return YES;
    }
    else
    {
        return NO;
    }
};

@implementation ISOpenQuestion
@synthesize answers = _answers;
@synthesize matchMode = _matchMode;
@synthesize customMatchFunc = _customMatchFunc;

- (id)initWithAnswers:(NSArray*)answers
{
    if (self = [super init])
    {
        _answers = [[NSMutableArray alloc] init];
        self.matchMode = kISOpenQuestionMatchModeClose;
        [self addAnswers:answers];
    }
    return self;
}

- (id)initWithAnswer:(NSString*)answer
{
    if (self = [super init])
    {
        _answers = [[NSMutableArray alloc] init];
        self.matchMode = kISOpenQuestionMatchModeClose;
        [self addAnswer:answer];
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        _answers = [[NSMutableArray alloc] init];
        self.matchMode = kISOpenQuestionMatchModeClose;
    }
    return self;
}

- (void)dealloc
{
    [_answers release];
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _answers = [[NSMutableArray alloc] init];
        [_answers addObjectsFromArray:[aDecoder decodeObjectForKey:_ISAnswersKey]];
        self.matchMode = [aDecoder decodeIntForKey:_ISMatchModeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.answers forKey:_ISAnswersKey];
    [aCoder encodeInt:self.matchMode forKey:_ISMatchModeKey];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p, answers: %@>",
            NSStringFromClass([self class]), self, _answers];
}

- (void)setCustomMatchFunc:(ISMatchFunc_t)custommatchFunc
{
    if (_customMatchFunc)
    {
        Block_release(_customMatchFunc);
    }
    
    if (custommatchFunc)
    {
        _customMatchFunc = Block_copy(custommatchFunc);
    }
    else
    {
        _customMatchFunc = nil;
    }
}


- (BOOL)responseCorrect:(ISQuestionResponse*)response
{
    if (![response isKindOfClass:[ISOpenQuestionResponse class]])
    {
        return NO;
    }
    
    ISOpenQuestionResponse* casted = (ISOpenQuestionResponse*)response;
    
    ISMatchFunc_t matchFunc = nil;
    
    if (_matchMode == kISOpenQuestionMatchModeCaseSensitive)
    {
        matchFunc = _ISCaseSensitiveMatchFunc;
    }
    else if (_matchMode == kISOpenQuestionMatchModeExact)
    {
        matchFunc = _ISExactMatchFunc;
    }
    else if (_matchMode == kISOpenQuestionMatchModeClose)
    {
        matchFunc = _ISCloseMatchFunc;
    }
    else if (_matchMode == kISOpenQuestionMatchModeCustom)
    {
        matchFunc = _customMatchFunc;
    }
    else
    {
        NSLog(@"invalid match mode: %i", _matchMode);
        return NO;
    }
    
    for (NSString* answer in _answers)
    {
        if (matchFunc(answer, casted.response))
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)addAnswer:(NSString*)answer
{
    [_answers addObject:answer];
}

- (void)addAnswers:(NSArray*)answers
{
    [_answers addObjectsFromArray:answers];
}

- (void)removeAllAnswers
{
    [_answers removeAllObjects];
}

@end
