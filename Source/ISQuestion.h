/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

extern NSString * const _ISTextKey;

@interface ISQuestionResponse : NSObject <NSCoding>
@property(nonatomic, strong)NSDictionary* userData;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end

@interface ISEmptyQuestionResponse : ISQuestionResponse

+ (ISEmptyQuestionResponse*)emptyResponse;

@end

@interface ISQuestion : NSObject <NSCoding>
@property(nonatomic, copy)NSString* text;
@property(nonatomic, strong)NSDictionary* userData;
@property(nonatomic, assign)int scoreValue;
@property(nonatomic, strong) NSString* questionType;
@property(nonatomic, strong) NSString* questionSubType;


- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (BOOL)responseCorrect:(ISQuestionResponse*)response;

@end
