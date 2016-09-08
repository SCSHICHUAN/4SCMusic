//
//  SCCentreController.m
//  SCMusic
//
//  Created by 蓝科 on 16/5/17.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import "SCCentreController.h"
#import "SCMusicCell.h"
#import "SCMusicDataModle.h"
#import "SCTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#define KHeaderH 400
#define kInsetTop 150
@interface SCCentreController ()<UITableViewDataSource,UITableViewDelegate,SCMusicCellDelegate>
{
    NSIndexPath *_oldIndexPath;
    CGFloat _cellY;
    CGFloat _contentOffsetY;
    UIImageView *_imageViewCell;
    NSTimer *_rotateCellImageViewTimer;
    int _now;
    int _past;
//    float current;
    UILabel *_playNamelable;
    id _timeObserve;
}

@property (nonatomic,strong)SCMusicCell *cell;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *modleDataArray;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIVisualEffectView *playView;
//@property(nonatomic,strong)SCTableViewCell *tableViewCell;
@property(nonatomic,strong)AVPlayer *plarer;
@property(nonatomic,strong)UILabel *lable;

@end

@implementation SCCentreController

-(AVPlayer *)plarer
{
    if (!_plarer) {
        _plarer = [[AVPlayer alloc] init];
    }
    return _plarer;
}



-(SCMusicCell *)cell
{
    if (_cell == nil) {
        _cell =  [[SCMusicCell alloc] initWithFrame:self.view.bounds];
        _cell.delegate =self;
    }
    return _cell;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.navigationController.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
         self.tableView.separatorStyle = UITableViewStylePlain;
        self.tableView.backgroundColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(70, 0, 70, 0);
        
    }
    return _tableView;
}

-(NSArray *)modleDataArray
{
    if (_modleDataArray == nil) {
        _modleDataArray = [SCMusicDataModle dataArray];
    }
    return _modleDataArray;
}
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _imageView.image = [UIImage imageNamed:@"IMG_0552.jpg"];
    }
    return _imageView;
}
-(UILabel *)lable
{
    if (!_lable) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
        _lable.text = @"SCMusic";
        _lable.textColor = [UIColor lightTextColor];
        _lable.textAlignment = UITextAlignmentCenter;
        _lable.font = [UIFont systemFontOfSize:30];
        
    }
    
    return _lable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"navbar"];
    
    
    
  
    
    
    [self.view addSubview:self.imageView];

    UIBlurEffect *blurEffect= [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
   
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.alpha = 0.98;
    
    effectView.frame =self.view.bounds;
    [self.view addSubview:effectView];
    
    
    
    
    [self.view addSubview:self.tableView];
   

    
    UIBlurEffect *blurEffect1= [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    
    UIVisualEffectView *effectView1 = [[UIVisualEffectView alloc] initWithEffect:blurEffect1];
    
    effectView1.frame =CGRectMake(0,self.view.bounds.size.height-64, self.view.bounds.size.width, 64);
    
    [self.view addSubview:effectView1];
    
    
    
    
    [self.view addSubview:self.lable];
    
    
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modleDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewCell *cell = [SCTableViewCell TableView:tableView];
    SCMusicDataModle *DataModle = self.modleDataArray[indexPath.row];
     cell.musicDataModle = DataModle;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0;
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    [_imageViewCell removeFromSuperview];
    self.cell.playTimeSlear.value = 0.0;
    [self.plarer removeTimeObserver:_timeObserve];
    self.cell.pastTimeLable.text = @"";
    self.cell.starTimeLable.text = @"";
    
    if (!(_oldIndexPath == indexPath)) {
        
        [_playView removeFromSuperview];
        _past = 0;
        
        SCMusicDataModle *DataModle = self.modleDataArray[indexPath.row];
        NSString *name = DataModle.name;
        
        SCTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setNameStr:name];
        [cell setMusicDataModleSelect:DataModle];
        
        
        SCMusicDataModle *DataModle1= self.modleDataArray[_oldIndexPath.row];
        NSString *name1 = DataModle1.name;
        SCTableViewCell *cell2 = [tableView cellForRowAtIndexPath:_oldIndexPath];
        [cell2 setNameStrWite:name1];
       
        self.cell.songName.text = DataModle.name;
        self.cell.singer.text = DataModle.singer;
        self.cell.special.text = DataModle.album;
        
        
        
        
        
        
        _oldIndexPath = indexPath;
        
        
        
        
        
    
    }else if(_oldIndexPath == indexPath){
        return;
    }
    
    SCTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   
    _cellY = cell.frame.origin.y;
    _contentOffsetY = self.tableView.contentOffset.y + 70;
    
    UIBlurEffect *blurEffect1= [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    _playView = [[UIVisualEffectView alloc] initWithEffect:blurEffect1];
    _playView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64 , self.view.bounds.size.width, 66);
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPlayView:)];
   
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showPlayView:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    [_playView addGestureRecognizer:swipeGestureRecognizer];
    [_playView addGestureRecognizer:tapGestureRecognizer];
    
    
    
    
    _playNamelable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 20)];
    _playNamelable.backgroundColor = [UIColor lightTextColor];
    _playNamelable.layer.borderColor = [UIColor redColor].CGColor;
    //阴影颜色
    _playNamelable.layer.shadowColor = [UIColor grayColor].CGColor;
    //阴影浓度
    _playNamelable.layer.shadowOpacity = 0.5f;
    //阴影的方向以及大小
    _playNamelable.layer.shadowOffset = CGSizeMake(5, 5);
    _playNamelable.textAlignment = UITextAlignmentCenter;
    _playNamelable.text = cell.nameLable.text;
    
    
    
    _imageViewCell = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 60, 60)];
    _imageViewCell.backgroundColor = [UIColor clearColor];
    _imageViewCell. layer.cornerRadius = 30;
    _imageViewCell.clipsToBounds = YES;
    
//    if (cell.imageView.image) {
      _imageViewCell.image = cell.cellImage;
//    }else{
//       _imageViewCell.image = [UIImage imageNamed:@"未标题-1"];
//    }
    
    
    
  
    [self.playView addSubview:_playNamelable];
    [self.view addSubview:self.playView];
    
    

    [UIView animateWithDuration:0.1 animations:^{
        self.playView.frame = CGRectMake(10,5+ _cellY-_contentOffsetY +6 +64, 300, 50);
        [self.playView reloadInputViews];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.playView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +60, 320, 70);
            
           
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.8 animations:^{
                
                self.playView.frame = CGRectMake(0,self.view.bounds.size.height-64, self.view.bounds.size.width,64);
                
                [self.playView addSubview:_imageViewCell];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    self.playView.frame = CGRectMake(0,self.view.bounds.size.height-64-10, self.view.bounds.size.width,64);
                                   } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        self.playView.frame = CGRectMake(0,self.view.bounds.size.height-64, self.view.bounds.size.width,64);
                       
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 animations:^{
                            self.playView.frame = CGRectMake(0,self.view.bounds.size.height-64-4, self.view.bounds.size.width,64);
                            
                        } completion:^(BOOL finished) {
            
                            [UIView animateWithDuration:0.05 animations:^{
                                
                                self.playView.frame = CGRectMake(0,self.view.bounds.size.height-64, self.view.bounds.size.width,64);
                               
                            }];
                            
                        }];
                    }];
                }];
                
            }];
        }];

    }];

    
    
    SCMusicDataModle *DataModle = self.modleDataArray[indexPath.row];
    
    
    NSURL * urlm  = [NSURL URLWithString:DataModle.mp3Url];
    AVPlayerItem * songItem = [[AVPlayerItem alloc]initWithURL:urlm];
    self.plarer = [[AVPlayer alloc]initWithPlayerItem:songItem];
    self.plarer.volume = 0.3;

    
    [self.plarer play];

   
    
    __weak SCCentreController *weakSelf = self;
      _timeObserve =  [self.plarer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
         float   current = CMTimeGetSeconds(time);
       
        float total = CMTimeGetSeconds(songItem.duration);
        if (current) {
            float    progress = current / total;
            
            
            

            weakSelf.cell.starTimeLable.text = [NSString stringWithFormat:@"%02d:%02d",(NSInteger)current / 60,(NSInteger)current % 60];
//            self.ladel.textColor = [UIColor whiteColor];
//            
            weakSelf.cell.pastTimeLable.text = [NSString stringWithFormat:@"%02d:%02d",((NSInteger)total -(NSInteger)current)/ 60,((NSInteger)total-(NSInteger)current) % 60];
//
//            self.lable2.textColor = [UIColor whiteColor];
//            
            weakSelf.cell.playTimeSlear.maximumValue = total;
           
              weakSelf.cell.playTimeSlear.value  = current;
            
            //    self.view1.layer.shadowColor = [UIColor blackColor].CGColor;
            //            self.view1.layer.shadowOpacity = 0.6;
            //    self.view1.layer.shadowOffset = CGSizeMake(5, 5);
            //            self.view1.layer.cornerRadius = 130;
            
            
        NSString  *playTime = [NSString stringWithFormat:@"%.f",current];
        
            NSString  *playDuration = [NSString stringWithFormat:@"%.2f",total];
            
               NSLog(@"playTime = %@ ",playTime);
//            NSLog(@"playDuration = %@ ",playDuration);
//            NSLog(@"progress = %f",progress);
            
         [weakSelf rotateCellImageView];
            
      }
    }];
}
-(void)showPlayView:(UIView*)playView;
{
    
    [_playNamelable removeFromSuperview];
    
    
    playView = _playView;
    NSLog(@"_playView = %@ ",NSStringFromCGSize(playView.bounds.size));
    
    [UIView animateWithDuration:0.5 animations:^{
        _imageViewCell.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
        _imageViewCell.frame = CGRectMake(320*0.5-180*0.5,-300, 180, 180);
        _imageViewCell.layer.cornerRadius = 180*0.5;
        
    } completion:^(BOOL finished) {
    
    [UIView animateWithDuration:0.5 animations:^{
       
        _imageViewCell.center = self.view.center;
        _playView.frame = self.view.frame;
        
        [self.view addSubview:self.cell];
        
    } completion:^(BOOL finished) {
        
    }];
        
    }];

    
    
}

-(void)rotateCellImageView
{
    
   
    
    [UIView animateWithDuration:2 animations:^{
        for (int i = 0; i < 5; i++) {
            _imageViewCell.transform = CGAffineTransformRotate(_imageViewCell.transform, -M_1_PI/2);
        }
    } completion:^(BOOL finished) {
    
    }];
    
    
}

#pragma mark - SCMusicCellDelegate
-(void)playViewBackButtonClickLieIiBackSelf:(UIView *)view
{
    
    [UIView animateWithDuration:0.5 animations:^{
        _playView.frame = CGRectMake(0,self.view.bounds.size.height-64, self.view.bounds.size.width,64);
        _imageViewCell.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
        _imageViewCell.frame = CGRectMake(320*0.5-180*0.5,5, 180, 180);
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    
    
    [self.cell removeFromSuperview];
   
    [_playView addSubview:_playNamelable];
}
-(void)playTimeSlierAction:(UISlider *)slider
{
    NSLog(@"sliderddddddddd = %f ",slider.value);

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat alpha = (scrollView.contentOffset.y-(kInsetTop-64))/(KHeaderH-64-20);
    UIColor *color = [UIColor blackColor];
    if (alpha < 0.3) {
        self.lable.backgroundColor = [color colorWithAlphaComponent:alpha];
    }
    
   
}





@end
