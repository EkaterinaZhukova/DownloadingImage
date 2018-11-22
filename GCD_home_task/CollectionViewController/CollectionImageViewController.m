//
//  CollectionImageViewController.m
//  GCD_home_task
//
//  Created by Екатерина on 11/19/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "CollectionImageViewController.h"
#import "Masonry.h"
#import "CollectionViewCell.h"
#import "ResultViewController.h"
#import "HistoryManager.h"
#import "StateConstants.h"


#define reuseId @"cellID"



@interface UIImage(decompressImage)
-(UIImage*)decompressedImage;
@end

@implementation UIImage(decompressImage)
-(UIImage*)decompressedImage{
    CGImageRef imageRef = self.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat scaleFactor = 1;
    CGContextRef context = CGBitmapContextCreate(NULL, CGImageGetWidth(imageRef)/scaleFactor,
                                                 CGImageGetHeight(imageRef)/scaleFactor,
                                                 8,
                                                 CGImageGetWidth(imageRef)/scaleFactor*4,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    CGColorSpaceRelease(colorSpace); if (!context) {
        return self; }
    CGRect rect = (CGRect){CGPointZero, CGImageGetWidth(imageRef)/scaleFactor, CGImageGetHeight(imageRef)/scaleFactor};
    CGContextDrawImage(context, rect, imageRef);
    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(context); CGContextRelease(context);
    if (!decompressedImageRef) { return self;
    }
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIImage *decompressedImage = [UIImage imageWithCGImage:decompressedImageRef scale:scale orientation:UIImageOrientationUp];
    CGImageRelease(decompressedImageRef);
    if (decompressedImage && [decompressedImage isKindOfClass:[UIImage class]]) {
        return decompressedImage;
    }
    return self;
}

@end



@interface CollectionImageViewController ()
@property(nonatomic,retain) NSArray *urlArray;
@property(nonatomic,copy)NSOperationQueue* operationQueue;
@end

@implementation CollectionImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.urlArray = [NSArray arrayWithObjects:@"https://static1.squarespace.com/static/56db9642cf80a1b2c9a54968/t/5b10733488251b84141743ad/1527804743080/theMan_SamplePack_daspetey.jpg",@"https://spacers-tile-and-wood-flooring.co.uk/wp-content/uploads/2015/09/Tile-and-Wood-Flooring-SQ-101.jpg",@"https://i.imgur.com/jhbf6Vh.jpg",@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCiKE-GE4sruxNoGsPXkIxcyRwBdstv2AjSqk7KStu9YR9iG5I",@"https://i.pinimg.com/originals/23/75/91/237591118772b512f91ccacc4de72972.jpg",@"https://gatheredagain.com/wp-content/uploads/2014/05/Sample-Family-Reunion-Letters-1-1000x1000.jpg",@"https://gatheredagain.com/wp-content/uploads/2014/06/Organizing-your-Family-Reunion-Agenda-1-1000x1000.jpg",@"https://gatheredagain.com/wp-content/uploads/2014/06/Family-Reunion-Welcome-Speech-Samples-1.jpg",@"https://gatheredagain.com/wp-content/uploads/2014/04/How-to-Write-a-Family-Reunion-Welcome-Letter-1.jpg",@"https://gatheredagain.com/wp-content/uploads/2016/02/Funny-Family-Reunion-Jokes.jpg",@"https://imgix.bustle.com/rehost/2016/9/13/e9f78bad-b295-4506-8a78-9b6d0ea5a8a7.jpg?w=970&h=582&fit=crop&crop=faces&auto=format&q=70",@"https://blackoctopus-sound.com/wp-content/uploads/2014/11/funk-legends-1000x1000.png",@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSb32aR4_2g4WX2-6edr9mnAAopBILVxemfX0i9qx7xrVBA7Mh",@"https://eutopie-parfums.com/wp-content/uploads/2015/03/eutopie-sample-set-1000x1000.jpg",@"https://cdn.shopify.com/s/files/1/0261/6507/products/Dyneema_Composite_Fabric_-_sample_swatch_ring_1a_1200x.jpg?v=1535472877",@"https://coda.newjobs.com/api/imagesproxy/ms/niche/images/can/film.jpg",@"https://www.colourbox.dk/preview/2781967-farverige-fyrvaerkeri-paa-den-sorte-himmel-baggrunden.jpg",@"https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/December_Fog_01.jpg/1280px-December_Fog_01.jpg",@"https://images.unsplash.com/photo-1536746803623-cef87080bfc8?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=e6627c9716507abba4d778e9ef373f75&w=1000&q=80",@"https://cdn.rekkerd.org/wp-content/uploads/2017/06/Splice-Sounds-Graves-Sample-Pack-700x700.jpg",nil];
    
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:CollectionViewCell.class forCellWithReuseIdentifier:reuseId];
    collectionView.backgroundColor = UIColor.greenColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(closeButton.mas_bottom);
        make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
    }];
    
    _operationQueue = [NSOperationQueue new];
    [_operationQueue setMaxConcurrentOperationCount:1];
}
- (void) closeView{
    self.onCloseAction();
}
- (void)dealloc
{
    NSLog(@"Dealloc collectionVIew");
}
-(NSData* )downloadURL: (NSURL* )url{
    return [NSData dataWithContentsOfURL:url];
}

@end


@interface CollectionImageViewController(CollectionViewDataSourceCategory) <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end
@implementation CollectionImageViewController(CollectionViewDataSourceCategory)


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    __weak typeof(self)weakSelf = self;
    NSString *index = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    cell.backgroundColor = UIColor.lightGrayColor;
    [cell updateIndex:index];
    cell.currentIndex = index;
    [cell updateCurrentUrl:[NSURL URLWithString:self.urlArray[indexPath.row]]];
    
    HistoryManager* manager = [HistoryManager shared];
    __block NSData *data = nil;
    cell.block = [NSBlockOperation blockOperationWithBlock:^{
        
        NSString* str = [[NSString stringWithFormat:@"%@",[NSDate cuurentDateInFormat]] stringByAppendingString:[StateConstants beginConfiguration]];
        if(manager.result[index] == NULL){
            [manager.result setObject:[[NSMutableArray alloc]init] forKey:index];
        }
        [manager.result[index] addObject:str];
        NSURL *url = [NSURL URLWithString: self.urlArray[indexPath.row]];
        data = [weakSelf downloadURL:url];
        UIImage* myImage = [UIImage imageWithData:data];
        [myImage decompressedImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell updateView:myImage :url];
        });
    }];
    [weakSelf.operationQueue addOperation:cell.block];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, collectionView.frame.size.height);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ResultViewController* resultTableVC = [[ResultViewController alloc]init];
    resultTableVC.onCloseAction = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    resultTableVC.index = [NSString stringWithFormat:@"%ld",indexPath.row];
    [self.navigationController pushViewController:resultTableVC animated:YES];
}

@end

