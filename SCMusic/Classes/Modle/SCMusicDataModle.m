//
//  SCMusicDataModle.m
//  SCMusic
//
//  Created by 蓝科 on 16/5/17.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import "SCMusicDataModle.h"

@implementation SCMusicDataModle



-(instancetype)initWithDictnoarty:(NSDictionary *)dict

{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)musicDataDictnoarty:(NSDictionary *)dict
{
    return [[SCMusicDataModle alloc] initWithDictnoarty:dict];
}

+(NSArray *)dataArray
{
    NSMutableArray *mArry = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MusicInfoList" ofType:@"plist"];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict in dataArray) {
        SCMusicDataModle *dataModle = [SCMusicDataModle musicDataDictnoarty:dict];
        [mArry addObject: dataModle];
    }
    return mArry;
}


@end
