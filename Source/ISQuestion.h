/*
 By: Justin Meiners
 
 Copyright (c) 2013 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface ISQuestionResponse : NSObject <NSCoding>
@property(nonatomic, retain)NSDictionary* userData;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end

@interface ISEmptyQuestionResponse : ISQuestionResponse

+ (ISEmptyQuestionResponse*)emptyResponse;

@end

@interface ISQuestion : NSObject <NSCoding>
@property(nonatomic, copy)NSString* text;
@property(nonatomic, retain)NSDictionary* userData;
@property(nonatomic, assign)int scoreValue;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (BOOL)responseCorrect:(ISQuestionResponse*)response;

@end
