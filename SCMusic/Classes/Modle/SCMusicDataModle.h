//
//  SCMusicDataModle.h
//  SCMusic
//
//  Created by 蓝科 on 16/5/17.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCMusicDataModle : NSObject

@property (nonatomic,strong)NSString *mp3Url;
@property (nonatomic,strong)NSNumber *id;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *picUrl;
@property (nonatomic,strong)NSString *blurPicUrl;
@property (nonatomic,strong)NSString *album;
@property (nonatomic,strong)NSString *singer;
@property (nonatomic,strong)NSNumber *duration;
@property (nonatomic,strong)NSString *artists_name;
@property (nonatomic,strong)NSString *lyric;


-(instancetype)initWithDictnoarty:(NSDictionary*)dict;
+(instancetype)musicDataDictnoarty:(NSDictionary*)dict;

+(NSArray *)dataArray;


@end
