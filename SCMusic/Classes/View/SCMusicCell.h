//
//  SCMusicCell.h
//  SCMusic
//
//  Created by 蓝科 on 16/5/17.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCMusicCell;
@protocol SCMusicCellDelegate <NSObject>

-(void)playViewBackButtonClickLieIiBackSelf:(UIView*)view;
-(void)playTimeSlierAction:(UISlider *)slider;
@end


@interface SCMusicCell : UIView
- (IBAction)backButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISlider *playTimeSlear;
@property(nonatomic,weak)id<SCMusicCellDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame;
@property (weak, nonatomic) IBOutlet UILabel *starTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *pastTimeLable;
- (IBAction)playTimeSlierAction:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UILabel *special;

@end
