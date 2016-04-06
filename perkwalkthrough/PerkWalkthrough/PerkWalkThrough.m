//
//  PerkWalkThrough.m
//  perkwalkthrough
//
//  Created by Ranjithkumar on 05/04/16.
//  Copyright © 2016 womistudios. All rights reserved.
//

#import "PerkWalkThrough.h"

#define NUMBER_OF_PAGES 3

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)loadWalkthrough{
    bgArray = [NSArray arrayWithObjects:@"PerkWalkThrough.bundle/wt_bg_1.png",@"PerkWalkThrough.bundle/wt_bg_2.png",@"PerkWalkThrough.bundle/wt_bg_3.png", nil];
    self.view.backgroundColor = [UIColor blackColor];
    //Scroll
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self getImageSizeFor:[UIImage imageNamed:@"PerkWalkThrough.bundle/wt_bg_1.png"]].height)];
    scroll.delegate = self;
    scroll.contentSize = CGSizeMake(scroll.frame.size.width * NUMBER_OF_PAGES, scroll.frame.size.height);
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scroll];
    
    //Adding the Page Control
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scroll.frame.size.height - 40, scroll.frame.size.width, 25)];
    pageControl.numberOfPages = NUMBER_OF_PAGES;
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



//Helpers
- (CGSize)getImageSizeFor:(UIImage *)image{
    float ratio = image.size.width / image.size.height;
    NSLog(@"%f",ratio);
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width / ratio);
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
