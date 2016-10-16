//
//  CWCircleView.m
//
//  Created by ChenWei on 16/10/5.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWCircleView.h"
/** 用来显示图片的imageView的总数 */
NSInteger kImageViewTotalCounts = 4;

@interface CWCircleView () <UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray<UIImageView *> *imageViews;
@property (weak, nonatomic) UIScrollView *scrollView;

/** 在中间显示的图片在数组中的索引:初始化为0 */
@property (assign, nonatomic) NSInteger currentIndex;

@property (weak, nonatomic) NSTimer *timer;

/** 指示器 */
@property (weak, nonatomic) UIPageControl *indicater;

@end

@implementation CWCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 1.初始化UI
        [self setupUI];
        
        // 2.初始化正中间显示的图片索引
        self.currentIndex = 0;
        
        // 3.添加图片点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        tap.delaysTouchesBegan = YES;
        
        // 4.自动轮播时间
        self.autoTime = 3;
        
        // 5.默认图片的大小和间距
        self.imageViewSize = CGSizeMake(300, 150);
        self.imageViewMargin = 10;
        
        // 6.
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
     self.scrollView.frame = CGRectMake((self.bounds.size.width - self.imageViewSize.width - self.imageViewMargin) * 0.5 , 0, self.imageViewSize.width + self.imageViewMargin, self.imageViewSize.height);
    
    // 2.设置scrollView的contensize
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * 5, self.scrollView.bounds.size.height);
    
    // 3.设置scrollView里面iamgeView的frame
    for (int i = 0; i < kImageViewTotalCounts; i++) {
        /// 倍数
        NSInteger multiple = i + 1;
        self.imageViews[i].frame = CGRectMake(self.imageViewMargin * 0.5  + multiple * self.scrollView.bounds.size.width, 0, self.imageViewSize.width, self.imageViewSize.height);
    }
    
    // 4. 设置指示器frame
    if (self.indicater != nil) {
        self.indicater.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 20);
    }
    
    // 5.初始化scrollView的contenOffset
    [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.bounds.size.width, 0) animated:NO];

}

/** 添加子控件 */
- (void)setupUI {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
     scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.clipsToBounds = NO;
    scrollView.delegate = self;
    
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    self.imageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < kImageViewTotalCounts; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.imageViews addObject:imageView];
        [scrollView addSubview:imageView];
    }
}

#pragma mark - 监听图片点击tap手势
- (void)tap:(UITapGestureRecognizer *)tap {
    NSInteger index = 0;
    CGPoint point = [tap locationInView:_scrollView];
    for (int i = 0; i < self.imageNames.count - 1; i++) {
        if (CGRectContainsPoint(self.imageViews[i].frame, point)) {
            if (i == 0) {
                index = [self leftIndex:self.currentIndex];
            }else if (i == 1) {
                index = self.currentIndex;
            }else index = [self rightIndex:self.currentIndex];
            
             NSAssert(self.handlePictureClickedBlock != nil, @"图片点击事件的Block没有完成");
            if (self.handlePictureClickedBlock != nil) {
                self.handlePictureClickedBlock(index);
            }
            break;
        }
    }
}

#pragma mark - UISUIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 1.加载图片
    // 1.1左边滑动 : 添加右边将要加载的图片
    if (scrollView.contentOffset.x >= 3 * scrollView.bounds.size.width - (self.bounds.size.width - self.imageViewSize.width) * 0.5) {
        if (self.imageViews.lastObject.image == nil) {
            self.imageViews.lastObject.frame = CGRectMake(self.imageViewMargin * 0.5  + 4 * self.scrollView.bounds.size.width, 0, self.imageViewSize.width, self.imageViewSize.height);
            NSInteger willShowIndex = [self willAddImageIndexWithCurrentIndex:self.currentIndex isLeftScrolling:YES];
           
            [self.imageViews.lastObject sd_setImageWithURL:self.imageNames[willShowIndex] placeholderImage:nil];
        }
    }
    
    // 1.2右边滑动 添加左边将要加载的图片
    if (scrollView.contentOffset.x <= scrollView.bounds.size.width + (self.bounds.size.width - self.imageViewSize.width)) {
        if (self.imageViews.lastObject.image == nil) {
            self.imageViews.lastObject.frame = CGRectMake(self.imageViewMargin * 0.5  + 0 * self.scrollView.bounds.size.width, 0, self.imageViewSize.width, self.imageViewSize.height);
            
            NSInteger willShowIndex = [self willAddImageIndexWithCurrentIndex:self.currentIndex isLeftScrolling:NO];
            [self.imageViews.lastObject sd_setImageWithURL:self.imageNames[willShowIndex] placeholderImage:nil];
        }
    }
    
    // 2.调整scrollView的contenOffset,更新视图
    if (scrollView.contentOffset.x >= 3 * scrollView.bounds.size.width) { // 2.1左边滑动
        CGFloat delta = scrollView.contentOffset.x - 3 * scrollView.bounds.size.width;
        // 2.1.1 设置图片
        [self.imageViews[0] sd_setImageWithURL:self.imageNames[self.currentIndex] placeholderImage:nil];
       
        NSInteger midleIndex = [self rightIndex:self.currentIndex];
        [self.imageViews[1] sd_setImageWithURL:self.imageNames[midleIndex] placeholderImage:nil];
        
        NSInteger rightIndex = [self rightIndex:midleIndex];
        [self.imageViews[2] sd_setImageWithURL:self.imageNames[rightIndex] placeholderImage:nil];

        self.imageViews.lastObject.image = nil;
      
        // 2.1.2 修改当前正中间图片索引(一定要设置在下面调整scrollView的contenOffset前)
        self.currentIndex = midleIndex;
        
        // 2.1.3调整scrollView的contenOffset
        scrollView.contentOffset = CGPointMake(2 * scrollView.bounds.size.width - delta, 0);

    }else if (scrollView.contentOffset.x <= scrollView.bounds.size.width ) { // 2.2右边滑动
        // 2.2.1 设置图片
        NSInteger nextWillShowIndex = [self willAddImageIndexWithCurrentIndex:self.currentIndex isLeftScrolling:NO];
        [self.imageViews[0] sd_setImageWithURL:self.imageNames[nextWillShowIndex] placeholderImage:nil];
        
        NSInteger middleIndex = [self leftIndex:self.currentIndex];
        [self.imageViews[1] sd_setImageWithURL:self.imageNames[middleIndex] placeholderImage:nil];
        
        [self.imageViews[2] sd_setImageWithURL:self.imageNames[self.currentIndex] placeholderImage:nil];
        
        self.imageViews.lastObject.image = nil;
        
        // 2.2.2 修改当前正中间图片索引 (一定要设置在下面调整scrollView的contenOffset前)
        self.currentIndex = middleIndex;
       
        // 2.2.3调整scrollView的contenOffset
        CGFloat delta = scrollView.contentOffset.x - scrollView.bounds.size.width;
        [scrollView setContentOffset:CGPointMake(2 * scrollView.bounds.size.width - delta  , 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self startTimer];
    
}

#pragma mark - 内部方法
/**
 计算传入索引的下一张图片索引

 @param currentIndex 传入的图片索引

 @return 返回传入索引的下一张图片索引
 */
- (NSInteger)rightIndex:(NSInteger)currentIndex {
    NSInteger rightIndex = currentIndex + 1;
    if (rightIndex > self.imageNames.count - 1) {
        rightIndex = 0;
    }
    return rightIndex;
}

/**
 计算传入索引的前上一张图片索引
 
 @param currentIndex 传入的图片索引
 
 @return 返回传入索引的上一张图片索引
 */
- (NSInteger)leftIndex:(NSInteger)currentIndex {
    NSInteger leftIndex = currentIndex - 1;
    if (leftIndex < 0) {
        leftIndex = self.imageNames.count - 1;
    }
    return leftIndex;
}

/**
 将要加载的图片的索引

 @param currentIndex    当前正中间显示的图片索引
 @param isLeftScrolling YES:表示左滑,右边有新图片要加载. NO : 表示右滑,左边有新图片要加载.

 @return 将要加载的图片的索引
 */
- (NSInteger)willAddImageIndexWithCurrentIndex:(NSInteger)currentIndex isLeftScrolling:(BOOL)isLeftScrolling {
    NSInteger index = 0;
    if (isLeftScrolling) {
       index =  [self rightIndex:currentIndex];
        index = [self rightIndex:index];
        
    }else {
        index = [self leftIndex:currentIndex];
        index = [self leftIndex:index];
    }
    
    return index;
}

/** 开启定时器 */
- (void)startTimer {
    
    
    // 0. 先取消前面的定时器
    [self.timer invalidate];
    
    if (self.imageViews[1].image == nil) {
        return;
    }
    
    // 1. 设置当前的定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoTime target:self selector:@selector(autoNextPage) userInfo:nil repeats:YES];

    // NSLog(@"%s", __func__);
}

/** 停止定时器 */
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
    // NSLog(@"stoptimer %s", __func__);
}

/** 自动轮播到下一页 */
- (void)autoNextPage {
    
    [self.scrollView setContentOffset:CGPointMake(3 * self.scrollView.bounds.size.width, 0) animated:YES];
    // NSLog(@"autoNextPage ---");
    
}

- (void)showIndicater:(BOOL)isShow {
    if (isShow && self.indicater == nil) {
        UIPageControl *indicater = [[UIPageControl alloc] init];
        self.indicater = indicater;
        [self insertSubview:indicater aboveSubview:self.subviews.lastObject];
        
        indicater.numberOfPages = self.imageViews.count;
        indicater.pageIndicatorTintColor = [UIColor lightGrayColor];
        indicater.currentPageIndicatorTintColor = [UIColor redColor];
        self.indicater.hidden = NO;
    }else {
        self.indicater.hidden = YES;
    }
    
}

/** 重写方法来设置指示器页码 */
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
   
    
    self.indicater.currentPage = currentIndex;
}

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    
        // 1.更新指示器总页数
        self.indicater.numberOfPages = imageNames.count;
        
        // 2.从初始位置加载图片
        self.currentIndex = 0;
        NSInteger imageIndex = 0;
        for ( int i = 0; i < 3; i++) {
            switch (i) {
                case 0:
                    imageIndex = [self leftIndex:self.currentIndex];
                    break;
                case 1:
                    imageIndex = self.currentIndex;
                    break;
                case 2:
                    imageIndex = [self rightIndex:self.currentIndex];
                    break;
                    
                default:
                    break;
            }
            
            [self.imageViews[i] sd_setImageWithURL:self.imageNames[imageIndex] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [self startTimer];
            }];
        }
        
        // 3.开启定时器
        [self startTimer];
}

@end














