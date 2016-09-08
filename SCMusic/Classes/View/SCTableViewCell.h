//
//  SCTableViewCell.h
//  SCMusic
//
//  Created by 蓝科 on 16/5/18.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCMusicDataModle;


@interface SCTableViewCell : UITableViewCell
@property(nonatomic,strong)SCMusicDataModle *musicDataModle;

+(SCTableViewCell *)TableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLableBackGround;
@property(nonatomic,assign)NSString *nameStr;
@property(nonatomic,assign)NSString *nameStrWite;

@property(nonatomic,strong)SCMusicDataModle *musicDataModleSelect;
@property(nonatomic,strong)UIImage *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;



@end
