/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import "ISQuestion.h"

static NSString * const _ISUserDataKey = @"userData";
NSString * const _ISTextKey = @"text";
static NSString * const _ISTypeKey = @"type";
static NSString * const _ISScoreValueKey = @"scoreValue";

@implementation ISQuestionResponse

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.userData = [aDecoder decodeObjectForKey:_ISUserDataKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userData forKey:_ISUserDataKey];
}

@end

@implementation ISEmptyQuestionResponse

+ (ISEmptyQuestionResponse*)emptyResponse
{
    return [[self alloc] init];
}

@end

@implementation ISQuestion

- (id)init
{
    if (self = [super init])
    {
        self.text = nil;
        self.userData = nil;
        self.scoreValue = 1;
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.text = [aDecoder decodeObjectForKey:_ISTextKey];
        self.userData = [aDecoder decodeObjectForKey:_ISUserDataKey];
        self.scoreValue = [aDecoder decodeIntForKey:_ISScoreValueKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_text forKey:_ISTextKey];
    [aCoder encodeObject:_userData forKey:_ISUserDataKey];
    [aCoder encodeInt:_scoreValue forKey:_ISScoreValueKey];
}


- (BOOL)responseCorrect:(ISQuestionResponse*)response
{
    return NO;
}

@end
