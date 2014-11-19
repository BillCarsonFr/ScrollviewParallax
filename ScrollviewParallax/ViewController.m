//
//  ViewController.m
//  ScrollviewParallax
//
//  Created by Valere on 18/11/14.
//  Copyright (c) 2014 share. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Programmatically";
    
    NSMutableDictionary* views = [NSMutableDictionary new];
    views[@"super"] = self.view;
    views[@"topGuide"] = self.topLayoutGuide; // The bottom of the navigation bar, if a navigation bar is visible. The bottom of the status bar, if only a status bar is visible .. etc...
    
    
    //Create the ScrollView
    UIScrollView* scrollView = [UIScrollView new];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO; //we are using auto layout
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:scrollView];
    views[@"scrollView"] = scrollView;
  
    //Create the scrollview contentview
    UIView* contentView = [UIView new];
    contentView.translatesAutoresizingMaskIntoConstraints = NO; //we are using auto layout
    [scrollView addSubview:contentView];
    views[@"contentView"] = contentView;

    //Add the image view and other addtional views to the content view
    UIImageView* topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wind.jpg"]];
    topImageView.translatesAutoresizingMaskIntoConstraints = NO; //we are using auto layout
    topImageView.contentMode = UIViewContentModeScaleAspectFill;
    topImageView.clipsToBounds = YES;
    [contentView addSubview:topImageView];
    views[@"topImageView"] = topImageView;
    
    //Add other content to the scrollable view
    UIView* subContentView = [UIView new];
    subContentView.translatesAutoresizingMaskIntoConstraints = NO; //we are using auto layout
    [contentView addSubview:subContentView];
    views[@"subContentView"] = subContentView;


    //Now Let's do the layout
    NSArray* constraints;
    NSString* format;
    NSDictionary* metrics = @{@"imageHeight" : @150.0};
    
    //======== ScrollView should take all available space ========
    
    format = @"|-0-[scrollView]-0-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [self.view addConstraints:constraints];
    
    format = @"V:[topGuide]-0-[scrollView]-0-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [self.view addConstraints:constraints];
    
    
    
    //======== ScrollView Content should tie to all four edges of the scrollview ========
    
    format = @"|-0-[contentView]-0-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [scrollView addConstraints:constraints];
    
    format = @"V:|-0-[contentView]-0-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [scrollView addConstraints:constraints];
    
    
    
    // ========== Layout the image horizontally
    
    format = @"|-0-[topImageView(==super)]-0-|"; // with trick to force content width
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [self.view addConstraints:constraints];

    
    
    // ========== Put the sub view height, and leave room for image
    
    format = @"|-0-[subContentView]-0-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [scrollView addConstraints:constraints];
    
    
    // we leave some space between the top for the image view
    format = @"V:|-imageHeight-[subContentView(700)]-0-|"; /*the view height is set to 700 for the example in order to have enough content */
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
    [scrollView addConstraints:constraints];
    
    
    
    // Start of the magic
    
    format = @"V:[topImageView]-0-[subContentView]"; // image view bottom is subcontent top
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [contentView addConstraints:constraints];
    
    // image view top is the top layout
    // But we lower the priority to let it break if you scroll enough to have the imageViewBottom higher than the top layout guide
    format = @"V:[topGuide]-0@750-[topImageView]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [self.view addConstraints:constraints];
    
    // so add a lower than rule with higher priority (1000) to let the previous rule break;
    format = @"V:[topGuide]-<=0-[topImageView]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [self.view addConstraints:constraints];
    
    
    
    //Optional stuff, Add The A view
    UILabel* aView = [UILabel new];
    aView.text = @"A";
    aView.translatesAutoresizingMaskIntoConstraints = NO; //we are using auto layout
    aView.backgroundColor = [UIColor colorWithRed:0.79 green:0.9 blue:0.69 alpha:1];
    [aView setFont: [UIFont systemFontOfSize:44]];
    aView.textColor = [UIColor whiteColor];
    aView.textAlignment = NSTextAlignmentCenter;
    [subContentView addSubview:aView];
    views[@"aView"] = aView;
    
    format = @"|-0-[aView(143)]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [subContentView addConstraints:constraints];
    
    format = @"V:|-0-[aView(127)]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [subContentView addConstraints:constraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
