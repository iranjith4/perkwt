//
//  ViewController.m
//  perkwalkthrough
//
//  Created by Ranjithkumar on 05/04/16.
//  Copyright © 2016 womistudios. All rights reserved.
//

#import "ViewController.h"
#import "PerkWalkThrough.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addButtons];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addButtons{
    UIButton *openWalkthrough = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.90, 45)];
    [openWalkthrough setTitle:@"Open Walkthrough" forState:UIControlStateNormal];
    openWalkthrough.center = self.view.center;
    openWalkthrough.backgroundColor = [UIColor orangeColor];
    openWalkthrough.layer.cornerRadius = 5.0;
    openWalkthrough.layer.masksToBounds = YES;
    [openWalkthrough addTarget:self action:@selector(openWalkthrough) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openWalkthrough];
}

- (void)openWalkthrough{
    // **** Usage **** //
    PerkWalkThrough *perkWalkThrough = [[PerkWalkThrough alloc] init];
    [self presentViewController:perkWalkThrough animated:YES completion:nil];
}

@end
