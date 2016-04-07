//
//  PerkWalkThrough.m
//  perkwalkthrough
//
//  Created by Ranjithkumar on 05/04/16.
//  Copyright © 2016 womistudios. All rights reserved.
//

#import "PerkWalkThrough.h"

#define NUMBER_OF_PAGES 3
#define ORIENTATION [UIDevice currentDevice].orientation
#define PORTRAIT UIDeviceOrientationPortrait

@interface PerkWalkThrough ()<UIScrollViewDelegate>

@end

@implementation PerkWalkThrough{
    UIScrollView *scroll;
    UIPageControl *pageControl;
    NSArray *bgArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWalkthrough];
    [self addViewsToScroll];
    [self addButtons];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)loadWalkthrough{
    if (ORIENTATION == PORTRAIT){
        bgArray = [NSArray arrayWithObjects:@"PerkWalkThrough.bundle/portrait-wakthrough1-bg.png",@"PerkWalkThrough.bundle/portrait-wakthrough2-bg.png",@"PerkWalkThrough.bundle/portrait-wakthrough3-bg.png", nil];
    }else{
        bgArray = [NSArray arrayWithObjects:@"PerkWalkThrough.bundle/landscape-wakthrough1-bg.png",@"PerkWalkThrough.bundle/landscape-wakthrough2-bg.png",@"PerkWalkThrough.bundle/landscape-wakthrough3-bg.png", nil];
    }
    self.view.backgroundColor = [UIColor blackColor];
    //Scroll
    NSString *tempImageName;
    if (ORIENTATION == PORTRAIT){
        tempImageName = @"PerkWalkThrough.bundle/portrait-wakthrough1-bg.png";
    }else{
        tempImageName = @"PerkWalkThrough.bundle/landscape-wakthrough1-bg.png";
    }
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self getImageSizeFor:[UIImage imageNamed:tempImageName] forWidth:self.view.frame.size.width].height)];
    scroll.delegate = self;
    scroll.contentSize = CGSizeMake(scroll.frame.size.width * NUMBER_OF_PAGES, scroll.frame.size.height);
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scroll];
    
    //Adding the Page Control
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scroll.frame.size.height - 40, scroll.frame.size.width, 25)];
    pageControl.numberOfPages = NUMBER_OF_PAGES;
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scroll.frame.size.width;
    float fractionalPage = scroll.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
}

- (void)addViewsToScroll{
    int i = 0;
    for (NSString *imageName in bgArray) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * scroll.frame.size.width,0 , scroll.frame.size.width, scroll.frame.size.height)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        imageView.image = [UIImage imageNamed:imageName];
        [view addSubview:imageView];
        [scroll addSubview:view];
        i++;
    }
}

- (void)addButtons{
    
    //Calculating the remaining space and calculating according to it
    CGFloat remainingSpace = self.view.frame.size.height - scroll.frame.size.height;
    CGFloat signupH = remainingSpace * 0.23;
    CGFloat fbH = remainingSpace * 0.50;
    CGFloat loginH = remainingSpace * 0.25;
    CGFloat ySpace = remainingSpace * 0.02;
    CGFloat buttonW = self.view.frame.size.width * 0.90;
    
    UIImage *signup = [UIImage imageNamed:@"PerkWalkThrough.bundle/portrait-signup-text.png"];
    UIImage *fb = [UIImage imageNamed:@"PerkWalkThrough.bundle/portrait-button-facebook.png"];
    UIImage *login = [UIImage imageNamed:@"PerkWalkThrough.bundle/portrait-text-login.png"];
    
    UIButton *signupButton = [[UIButton alloc] initWithFrame:CGRectMake(0, scroll.frame.origin.y + scroll.frame.size.height + 3 * ySpace,[self getImageSizeFor:signup forHeight:signupH checkWidth:buttonW].width, [self getImageSizeFor:signup forHeight:signupH checkWidth:buttonW].height)];
    [signupButton setImage:signup forState:UIControlStateNormal];
    signupButton.center = CGPointMake(self.view.center.x, signupButton.center.y);
    [self.view addSubview:signupButton];
    
    UIButton *facebookButton = [[UIButton alloc] initWithFrame:CGRectMake(0, signupButton.frame.size.height + signupButton.frame.origin.y - signupH * 0.15,[self getImageSizeFor:fb forHeight:fbH checkWidth:buttonW].width, [self getImageSizeFor:fb forHeight:fbH checkWidth:buttonW].height)];
    [facebookButton setImage:fb forState:UIControlStateNormal];
    facebookButton.center = CGPointMake(self.view.center.x, facebookButton.center.y);
    [self.view addSubview:facebookButton];
    
    CGFloat signinMaxWidth;
    if (ORIENTATION == PORTRAIT) {
        signinMaxWidth = self.view.frame.size.width * 0.60;
    }else{
        signinMaxWidth = self.view.frame.size.width * 0.25;
    }
    
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, facebookButton.frame.size.height + facebookButton.frame.origin.y + 5, [self getImageSizeFor:login forHeight:loginH checkWidth:signinMaxWidth].width, [self getImageSizeFor:login forHeight:loginH checkWidth:signinMaxWidth].height)];
    [loginButton setImage:login forState:UIControlStateNormal];
    loginButton.center = CGPointMake(self.view.center.x, loginButton.center.y);
    [self.view addSubview:loginButton];
}



//Helpers
- (CGSize)getImageSizeFor:(UIImage *)image forWidth:(CGFloat)width{
    float ratio = image.size.width / image.size.height;
    NSLog(@"%f",ratio);
    return CGSizeMake(width, width / ratio);
}

- (CGSize)getImageSizeFor:(UIImage *)image forHeight:(CGFloat)height checkWidth:(CGFloat)checkWidth{
    float ratio = image.size.width / image.size.height;
    NSLog(@"%f",ratio);
    
    if (height * ratio > checkWidth) {
        return CGSizeMake(checkWidth, [self getImageSizeFor:image forWidth:checkWidth].height);
    }else{
        return CGSizeMake(height * ratio, height);
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
