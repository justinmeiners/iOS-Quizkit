/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@protocol QuizController <NSObject>
- (void)nextQuestion;
- (ISSession*)session;

@end
