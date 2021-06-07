//
//  PlatformPopViewController.m
//  PicgGsturesDemo
//
//  Created by  CXJ-2021 on 2020/12/26.
//

#import "PlatformPopViewController.h"
#import <STPopup.h>
#import "Cell_Platform.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface PlatformPopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray*images;
@end

@implementation PlatformPopViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.contentSizeInPopup = CGSizeMake(SCREEN_WIDTH, 187);
        self.landscapeContentSizeInPopup = CGSizeMake(400, 200);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_collectionView registerNib:[UINib nibWithNibName:@"Cell_Platform" bundle:nil] forCellWithReuseIdentifier:@"Cell_Platform"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _images = @[@"platform0",@"platform1",@"platform2",@"platform3"];
    self.popupController.backgroundView.userInteractionEnabled = true;
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        [self.popupController dismiss];
    }];
    [self.popupController.backgroundView addGestureRecognizer:tap];
}

- (IBAction)closeBtnClick:(id)sender {
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _images.count;
}
- (IBAction)closeBtnclick:(UIButton *)sender {
    [self.popupController dismiss];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell_Platform*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell_Platform" forIndexPath:indexPath];
    cell.platformImageView.image = [UIImage imageNamed:_images[indexPath.row]];
    cell.platformImageView.layer.borderWidth = 2;
    if (_platform==indexPath.row) {
        cell.platformImageView.layer.borderColor = UIColorFromHex(0xd4efe4).CGColor;
    }else{
        cell.platformImageView.layer.borderColor = [UIColor clearColor].CGColor;
    }
        
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.changeCallback) {
        self.changeCallback(false, @{@"index":@(indexPath.row)});
        [self.popupController dismiss];
    }
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
