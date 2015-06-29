//
//  LoyaltiViewController.m
//  AiCafe
//
//  Created by Soumen on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "LoyaltiViewController.h"

@interface LoyaltiViewController ()
{
    NSInteger rating;
    NSInteger i;
    NSInteger j;
    NSInteger w;
    NSInteger b;
}
@end

@implementation LoyaltiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    rating=3;
  if([UIScreen mainScreen].bounds.size.width==375)
  {
    for(i=1,w=0; i <= rating; i++,w++)
    {

            NSLog(@"white....%ld",(long)i);
           UIImageView *currentImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((68+(w*53)), 28, 33, 33)];
           [currentImageView1 setImage:[UIImage imageNamed:@"Loyalti_cup_white"]];
           [_LoyaltiDetailsAreaImgview addSubview:currentImageView1];

    }

    for(b=w,j=--i; j >= (5-rating); j--,b++)
    {
        UIImageView *currentImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake((68+(b*53)), 28, 33, 33)];
        [currentImageView2 setImage:[UIImage imageNamed:@"Loyalti_cup_black"]];
        [_LoyaltiDetailsAreaImgview addSubview:currentImageView2];
    }
  }
  else if([UIScreen mainScreen].bounds.size.width==414)
    {
        for(i=1,w=0; i <= rating; i++,w++)
        {
            
            NSLog(@"white....%ld",(long)i);
            UIImageView *currentImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((80+(w*56)), 28, 33, 33)];
            [currentImageView1 setImage:[UIImage imageNamed:@"Loyalti_cup_white"]];
            [_LoyaltiDetailsAreaImgview addSubview:currentImageView1];
            
        }
        
        for(b=w,j=--i; j >= (5-rating); j--,b++)
        {
            UIImageView *currentImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake((80+(b*56)), 28, 33, 33)];
            [currentImageView2 setImage:[UIImage imageNamed:@"Loyalti_cup_black"]];
            [_LoyaltiDetailsAreaImgview addSubview:currentImageView2];
        }
    }
    else
    {
        for(i=1,w=1; i <= rating; i++,w++)
        {
            UIImageView *currentImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((50*w), 28, 30, 30)];
            [currentImageView1 setImage:[UIImage imageNamed:@"Loyalti_cup_white"]];
            [_LoyaltiDetailsAreaImgview addSubview:currentImageView1];
        }
        
        for(b=i,j=--i; j >= (5-rating); j--,b++)
        {
            UIImageView *currentImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake((50*b), 28, 30, 30)];
            [currentImageView2 setImage:[UIImage imageNamed:@"Loyalti_cup_black"]];
            [_LoyaltiDetailsAreaImgview addSubview:currentImageView2];
        }
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
