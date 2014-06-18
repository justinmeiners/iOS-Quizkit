/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "ISMultipleChoiceQuestion.h"


static NSString * const _ISUserDataKey = @"userData";
static NSString * const _ISCorrectKey = @"correct";
static NSString * const _ISOptionsKey = @"options";
static NSString * const _ISAnswerIndexKey = @"answerIndex";
static NSString * const _ISAnswerIndexesKey = @"answerIndexes";
static NSString * const _ISSelectableOptionsKey = @"selectableOptions";

@implementation ISMultipleChoiceResponse

-(int)answerIndex {
    
    if(_answerIndexes.count > 0) {
        
        NSNumber* answerIndex = _answerIndexes[0];
        
        return answerIndex.intValue;
        
    } else {
        
        return -1;
    }
}

+ (ISMultipleChoiceResponse*)responseWithAnswerIndex:(int)answerIndex
{
    return [[self alloc] initWithAnswerIndexes:@[[NSNumber numberWithInt: answerIndex]]];
}

+ (ISMultipleChoiceResponse*)responseWithAnswerIndexes:(NSArray*)answerIndexes
{
    return [[self alloc] initWithAnswerIndexes:answerIndexes];
}

- (id)init
{
    if (self = [super init])
    {
        _answerIndexes = @[];
    }
    return self;
}

- (id)initWithAnswerIndex:(int)answerIndex
{
    if (self = [super init])
    {
        _answerIndexes = @[[NSNumber numberWithInt: answerIndex]];
    }
    return self;
}

- (id)initWithAnswerIndexes:(NSArray*)answerIndexes
{
    if (self = [super init])
    {
        _answerIndexes = answerIndexes;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        if([aDecoder decodeIntForKey:_ISAnswerIndexKey]) {
        
            int answerIndex = [aDecoder decodeIntForKey:_ISAnswerIndexKey];
        
            self.answerIndexes = @[[NSNumber numberWithInt: answerIndex]];
            
        } else {
        
            self.answerIndexes = [aDecoder decodeObjectForKey:_ISAnswerIndexesKey];
            
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_answerIndexes forKey:_ISAnswerIndexesKey];
}

- (id)initWithIndex:(int)answerIndex
{
    if (self = [super init])
    {
        _answerIndexes = @[[NSNumber numberWithInt: answerIndex]];
    }
    return self;
}

- (id)initWithIndexes:(NSArray*)answerIndexes
{
    if (self = [super init])
    {
        _answerIndexes = answerIndexes;
    }
    return self;
}

+ (ISMultipleChoiceResponse*)responseWithIndex:(int)index
{
    return [[ISMultipleChoiceResponse alloc] initWithIndexes: @[[NSNumber numberWithInt: index]]];
}

+ (ISMultipleChoiceResponse*)responseWithIndexes:(NSArray*)indexes
{
    return [[ISMultipleChoiceResponse alloc] initWithIndexes:indexes];
}

@end

@implementation ISMultipleChoiceOption

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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _options = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:_ISOptionsKey]];
        
        _correctOptions = [self calculateCorrectFromOptions:_options];
        
        if([aDecoder decodeObjectForKey:_ISSelectableOptionsKey]) {
            
            _selectableOptions = [aDecoder decodeObjectForKey:_ISSelectableOptionsKey];
        } else {
            
            _selectableOptions = @1;
        }
        
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_options forKey:_ISOptionsKey];
    [aCoder encodeObject:_selectableOptions forKey:_ISSelectableOptionsKey];
}


- (id)init
{
    if (self = [super init])
    {
        _options = [NSArray new];
        _correctOptions = [NSArray new];
        _selectableOptions = @1;
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
    _options = [_options arrayByAddingObject:option];
    
    _correctOptions = [self calculateCorrectFromOptions:_options];
}

- (void)addOptions:(NSArray*)options
{
    _options = [_options arrayByAddingObjectsFromArray:options];
    
    _correctOptions = [self calculateCorrectFromOptions:_options];
}

- (void)removeAllOptions
{
    _options = @[];
    
    _correctOptions = @[];
}

- (BOOL)responseCorrect:(ISQuestionResponse*)response
{
    if (![response isKindOfClass:[ISMultipleChoiceResponse class]])
    {
        return NO;
    }
    
    ISMultipleChoiceResponse* multipleChoiceResponse = (ISMultipleChoiceResponse*)response;
    
    if(multipleChoiceResponse.answerIndexes.count < _selectableOptions.integerValue || multipleChoiceResponse.answerIndexes.count > _selectableOptions.integerValue ) {
        
        return NO;
    }
    
    BOOL correct = YES;
    
    for (NSNumber *indexNumber in multipleChoiceResponse.answerIndexes) {
        
        int index = indexNumber.intValue;
        
        if (index < 0 || index > _options.count)
        {
            correct = NO;
            break;
        }
        
        ISMultipleChoiceOption* option = _options[index];
        
        if(!option.correct) {
            
            correct = NO;
            break;
        }
    }
    
    return correct;
}

-(NSArray*)calculateCorrectFromOptions:(NSArray*)options {
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (ISMultipleChoiceOption* option in options) {
        if(option.correct) {
        
            [array addObject:option];
        }
    }
    
    return [NSArray arrayWithArray:array];
}


@end
