/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "ISMultipleChoiceQuestion.h"

static NSString * const _ISTextKey = @"text";
static NSString * const _ISUserDataKey = @"userData";
static NSString * const _ISCorrectKey = @"correct";
static NSString * const _ISOptionsKey = @"options";
static NSString * const _ISAnswerIndexKey = @"answerIndex";

@implementation ISMultipleChoiceResponse
@synthesize answerIndex = _answerIndex;

+ (ISMultipleChoiceResponse*)responseWithAnswerIndex:(int)answerIndex
{
    return [[self alloc] initWithAnswerIndex:answerIndex];
}

- (id)init
{
    if (self = [super init])
    {
        _answerIndex = -1;
    }
    return self;
}

- (id)initWithAnswerIndex:(int)answerIndex
{
    if (self = [super init])
    {
        _answerIndex = answerIndex;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.answerIndex = [aDecoder decodeIntForKey:_ISAnswerIndexKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeInt:_answerIndex forKey:_ISAnswerIndexKey];
}

- (id)initWithIndex:(int)answerIndex
{
    if (self = [super init])
    {
        _answerIndex = answerIndex;
    }
    return self;
}

+ (ISMultipleChoiceResponse*)responseWithIndex:(int)index
{
    return [[ISMultipleChoiceResponse alloc] initWithIndex:index];
}
@end

@implementation ISMultipleChoiceOption
@synthesize text = _text;
@synthesize correct = _correct;
@synthesize userData = _userData;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.text = [aDecoder decodeObjectForKey:_ISTextKey];
        self.correct = [aDecoder decodeBoolForKey:_ISCorrectKey];
        self.userData = [aDecoder decodeObjectForKey:_ISUserDataKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_text forKey:_ISTextKey];
    [aCoder encodeBool:_correct forKey:_ISCorrectKey];
    [aCoder encodeObject:_userData forKey:_ISUserDataKey];
}


- (id)initWithText:(NSString*)text correct:(BOOL)correct
{
    if (self = [super init])
    {
        self.text = text;
        self.correct = correct;
        self.userData = NULL;
    }
    return self;
}

- (id)initWithText:(NSString*)text
           correct:(BOOL)correct
          userData:(NSDictionary*)userData
{
    if (self = [super init])
    {
        self.text = text;
        self.correct = correct;
        self.userData = userData;
    }
    
    return self;
}


- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p, text: %@ correct: %i>",
            NSStringFromClass([self class]), self, _text, _correct];
}


+ (ISMultipleChoiceOption*)optionWithText:(NSString*)text correct:(BOOL)correct
{
    return [[ISMultipleChoiceOption alloc] initWithText:text correct:correct];
}

@end

@implementation ISMultipleChoiceQuestion
@synthesize options = _options;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _options = [[NSMutableArray alloc] init];
        [_options addObjectsFromArray:[aDecoder decodeObjectForKey:_ISOptionsKey]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_options forKey:_ISOptionsKey];
}


- (id)init
{
    if (self = [super init])
    {
        _options = [[NSMutableArray alloc] init];
    }
    return self;
}


- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p, option count: %lu>",
            NSStringFromClass([self class]), self, (unsigned long)_options.count];
}

- (void)addOption:(ISMultipleChoiceOption*)option
{
    [_options addObject:option];
}

- (void)addOptions:(NSArray*)options
{
    [_options addObjectsFromArray:options];
}

- (void)removeAllOptions
{
    [_options removeAllObjects];
}

- (BOOL)responseCorrect:(ISQuestionResponse*)response
{
    if (![response isKindOfClass:[ISMultipleChoiceResponse class]])
    {
        return NO;
    }
    
    ISMultipleChoiceResponse* casted = (ISMultipleChoiceResponse*)response;
    
    int index = [casted answerIndex];
    
    if (index < 0 || index > _options.count)
    {
        return NO;
    }
    
    ISMultipleChoiceOption* option = _options[index];
    return option.correct;
}


@end
