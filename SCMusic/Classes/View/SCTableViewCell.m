//
//  SCTableViewCell.m
//  SCMusic
//
//  Created by 蓝科 on 16/5/18.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import "SCTableViewCell.h"
#import "SCMusicDataModle.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"


@interface SCTableViewCell ()
;

@property (weak, nonatomic) IBOutlet UILabel *singerName;
@property (weak, nonatomic) IBOutlet UILabel *specialName;
@property(nonatomic,strong)AVPlayer *player;

@end





@implementation SCTableViewCell

+(SCTableViewCell *)TableView:(UITableView *)tableView
{
    static NSString *cellIdentfille = @"cellIdentfille";
    SCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfille];
    if (cell == nil) {
          cell = [[NSBundle mainBundle] loadNibNamed:@"SCTableViewCell" owner:nil options:nil].firstObject;
        
            }
    
    return cell;
}



- (void)awakeFromNib {
  
}

-(void)setMusicDataModle:(SCMusicDataModle *)musicDataModle
{
    _musicDataModle = musicDataModle;
    self.nameLable.text = _musicDataModle.name;
    
    
    [NSThread detachNewThreadSelector:@selector(downloadData:) toTarget:self withObject:nil];
    
}


-(void)downloadData:(SCMusicDataModle *)dataModle
{
    NSURL *url = [NSURL URLWithString:_musicDataModle.picUrl];
    [self.pictureView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"未标题-1"]];
        
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *cellImage = [UIImage imageWithData:imageData];

    [self performSelectorOnMainThread:@selector(showData:)   withObject:cellImage waitUntilDone:NO];
}

-(void)showData:(UIImage *)image
{
//    self.pictureView.image = image;
    self.cellImage = image;
    
}

-(void)setNameStr:(NSString *)nameStr
{
    _nameStr = nameStr;
    self.nameLableBackGround.text = nameStr;
    self.nameLableBackGround.textColor = [UIColor blackColor];
    NSLog(@"nameStr = %@ ",nameStr);
    [self reloadInputViews];
}
-(void)setNameStrWite:(NSString *)nameStrWite
{
    _nameStrWite = nameStrWite;
    self.nameLableBackGround.textColor = [UIColor whiteColor];
//    self.nameLableBackGround.text = @"";
    self.singerName.text = @"";
    self.specialName.text = @"";
     [self reloadInputViews];

}

-(void)setMusicDataModleSelect:(SCMusicDataModle *)musicDataModleSelect
{
    _musicDataModleSelect = musicDataModleSelect;
    self.singerName.text = _musicDataModleSelect.singer;
    self.specialName.text = _musicDataModleSelect.album;
    [self reloadInputViews];
}



@end
