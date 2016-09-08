//
//  SCMusicCell.m
//  SCMusic
//
//  Created by 蓝科 on 16/5/17.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import "SCMusicCell.h"

@implementation SCMusicCell
-(instancetype)initWithFrame:(CGRect)frame;

{
    self= [super initWithFrame:frame];
    
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"SCMusicCell" owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

-(void)awakeFromNib
{
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
     swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;

     [self addGestureRecognizer:swipeGestureRecognizer];
}
-(void)swipe:(UISwipeGestureRecognizer *)swipe
{
    
    NSLog(@"%s",__func__);
    [self backButton:nil];
    
}
- (IBAction)backButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(playViewBackButtonClickLieIiBackSelf:)]) {
        [self.delegate playViewBackButtonClickLieIiBackSelf:self];
    }
}


- (IBAction)playTimeSlierAction:(UISlider *)sender {
    if ([self.delegate respondsToSelector:@selector(playTimeSlierAction:)]) {
        [self.delegate playTimeSlierAction:self.playTimeSlear];
    }
}
@end
