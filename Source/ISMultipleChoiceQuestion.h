/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>
#import "ISQuestion.h"

@interface ISMultipleChoiceResponse : ISQuestionResponse
@property(nonatomic, assign)int answerIndex;

+ (ISMultipleChoiceResponse*)responseWithAnswerIndex:(int)answerIndex;

- (id)init;
- (id)initWithAnswerIndex:(int)answerIndex;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (id)initWithIndex:(int)answerIndex;

+ (ISMultipleChoiceResponse*)responseWithIndex:(int)index;

@end

@interface ISMultipleChoiceOption : NSObject <NSCoding>
@property(nonatomic, retain)NSDictionary* userData;
@property(nonatomic, copy)NSString* text;
@property(nonatomic, assign)BOOL correct;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (id)initWithText:(NSString*)text correct:(BOOL)correct;

- (id)initWithText:(NSString*)text
           correct:(BOOL)correct
          userData:(NSDictionary*)userData;

+ (ISMultipleChoiceOption*)optionWithText:(NSString*)text correct:(BOOL)correct;

@end

@interface ISMultipleChoiceQuestion : ISQuestion
{
    NSMutableArray* _options;
}
@property(nonatomic, readonly)NSArray* options;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (void)addOption:(ISMultipleChoiceOption*)option;
- (void)addOptions:(NSArray*)options;
- (void)removeAllOptions;

- (BOOL)responseCorrect:(ISQuestionResponse*)response;

@end


