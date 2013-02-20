/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startQuiz:(id)sender
{
    if (_session)
    {
        [_session stop];
        NSLog(@"%f", [_session time]);
    }
    
    ISQuiz* quiz = [ISQuizParser quizNamed:@"programming.plist"];
    
    _session = [[ISSession alloc] init];
    
    [_session start:quiz];
    
}

@end
