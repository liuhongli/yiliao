//
//  TZPhotoPickerController.m
//  TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import "TZPhotoPickerController.h"
#import "TZImagePickerController.h"
#import "TZPhotoPreviewController.h"
#import "TZAssetCell.h"
#import "TZAssetModel.h"
#import "UIView+Layout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"

@interface TZPhotoPickerController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    UICollectionView *_collectionView;
    NSMutableArray *_photoArr;
    
    UIButton *_previewButton;
    UIButton *_okButton;
    UIImageView *_numberImageView;
    UILabel *_numberLable;
    UIButton *_originalPhotoButton;
    UILabel *_originalPhotoLable;
    
    BOOL _isSelectOriginalPhoto;
    BOOL _shouldScrollToBottom;
}
@property (nonatomic, strong) NSMutableArray *selectedPhotoArr;
@end

@implementation TZPhotoPickerController

- (NSMutableArray *)selectedPhotoArr {
    if (_selectedPhotoArr == nil) _selectedPhotoArr = [NSMutableArray array];
    return _selectedPhotoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _shouldScrollToBottom = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _model.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
    [[TZImageManager manager] getAssetsFromFetchResult:_model.result allowPickingVideo:imagePickerVc.allowPickingVideo completion:^(NSArray<TZAssetModel *> *models) {
        _photoArr = [NSMutableArray arrayWithArray:models];
        [self configCollectionView];
        [self configBottomToolBar];
    }];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 4;
    CGFloat itemWH = (self.view.width - 2 * margin - 4) / 4 - margin;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    CGFloat top = margin + 44;
    if (iOS7Later) top += 20;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(margin, top, self.view.width - 2 * margin, self.view.height - 50 - top) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceHorizontal = NO;
    if (iOS7Later) _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 2);
    _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
    _collectionView.contentSize = CGSizeMake(self.view.width, ((_model.count + 3) / 4) * self.view.width);
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"TZAssetCell" bundle:nil] forCellWithReuseIdentifier:@"TZAssetCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_shouldScrollToBottom && _photoArr.count > 0) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(_photoArr.count - 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        _shouldScrollToBottom = NO;
    }
}

- (void)configBottomToolBar {
    UIView *bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 50, self.view.width, 50)];
    CGFloat rgb = 253 / 255.0;
    bottomToolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    
    _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewButton.frame = CGRectMake(10, 3, 44, 44);
    [_previewButton addTarget:self action:@selector(previewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _previewButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_previewButton setTitle:@"预览" forState:UIControlStateNormal];
    [_previewButton setTitle:@"预览" forState:UIControlStateDisabled];
    [_previewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_previewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    _previewButton.enabled = NO;
    
    TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
    if (imagePickerVc.allowPickingOriginalPhoto) {
        _originalPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalPhotoButton.frame = CGRectMake(50, self.view.height - 50, 130, 50);
        _originalPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        _originalPhotoButton.contentEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
        [_originalPhotoButton addTarget:self action:@selector(originalPhotoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _originalPhotoButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_originalPhotoButton setTitle:@"原图" forState:UIControlStateNormal];
        [_originalPhotoButton setTitle:@"原图" forState:UIControlStateSelected];
        [_originalPhotoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_originalPhotoButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_originalPhotoButton setImage:[UIImage imageNamed:@"photo_original_def"] forState:UIControlStateNormal];
        [_originalPhotoButton setImage:[UIImage imageNamed:@"photo_original_sel"] forState:UIControlStateSelected];
        _originalPhotoButton.enabled = _selectedPhotoArr.count > 0;
        
        _originalPhotoLable = [[UILabel alloc] init];
        _originalPhotoLable.frame = CGRectMake(70, 0, 60, 50);
        _originalPhotoLable.textAlignment = NSTextAlignmentLeft;
        _originalPhotoLable.font = [UIFont systemFontOfSize:16];
        _originalPhotoLable.textColor = [UIColor blackColor];
        if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
    }
    
    _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _okButton.frame = CGRectMake(self.view.width - 44 - 12, 3, 44, 44);
    _okButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_okButton setTitle:@"确定" forState:UIControlStateNormal];
    [_okButton setTitle:@"确定" forState:UIControlStateDisabled];
    [_okButton setTitleColor:kOKButtonTitleColorNormal forState:UIControlStateNormal];
    [_okButton setTitleColor:kOKButtonTitleColorDisabled forState:UIControlStateDisabled];
    _okButton.enabled = NO;
    
    _numberImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_number_icon"]];
    _numberImageView.frame = CGRectMake(self.view.width - 56 - 24, 12, 26, 26);
    _numberImageView.hidden = _selectedPhotoArr.count <= 0;
    _numberImageView.backgroundColor = [UIColor clearColor];
    
    _numberLable = [[UILabel alloc] init];
    _numberLable.frame = _numberImageView.frame;
    _numberLable.font = [UIFont systemFontOfSize:16];
    _numberLable.textColor = [UIColor whiteColor];
    _numberLable.textAlignment = NSTextAlignmentCenter;
    _numberLable.text = [NSString stringWithFormat:@"%zd",_selectedPhotoArr.count];
    _numberLable.hidden = _selectedPhotoArr.count <= 0;
    _numberLable.backgroundColor = [UIColor clearColor];
    
    UIView *divide = [[UIView alloc] init];
    CGFloat rgb2 = 222 / 255.0;
    divide.backgroundColor = [UIColor colorWithRed:rgb2 green:rgb2 blue:rgb2 alpha:1.0];
    divide.frame = CGRectMake(0, 0, self.view.width, 1);

    [bottomToolBar addSubview:divide];
    [bottomToolBar addSubview:_previewButton];
    [bottomToolBar addSubview:_okButton];
    [bottomToolBar addSubview:_numberImageView];
    [bottomToolBar addSubview:_numberLable];
    [self.view addSubview:bottomToolBar];
    [self.view addSubview:_originalPhotoButton];
    [_originalPhotoButton addSubview:_originalPhotoLable];
}

#pragma mark - Click Event

- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
    if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [imagePickerVc.pickerDelegate imagePickerControllerDidCancel:imagePickerVc];
    }
    if (imagePickerVc.imagePickerControllerDidCancelHandle) {
        imagePickerVc.imagePickerControllerDidCancelHandle();
    }
}

- (void)previewButtonClick {
    TZPhotoPreviewController *photoPreviewVc = [[TZPhotoPreviewController alloc] init];
    photoPreviewVc.photoArr = [NSArray arrayWithArray:self.selectedPhotoArr];
    [self pushPhotoPrevireViewController:photoPreviewVc];
}

- (void)originalPhotoButtonClick {
    _originalPhotoButton.selected = !_originalPhotoButton.isSelected;
    _isSelectOriginalPhoto = _originalPhotoButton.isSelected;
    _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
    if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
}

- (void)okButtonClick {
    TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
    [imagePickerVc showProgressHUD];
    NSMutableArray *photos = [NSMutableArray array];
    NSMutableArray *assets = [NSMutableArray array];
    NSMutableArray *infoArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < _selectedPhotoArr.count; i++) {
        TZAssetModel *model = _selectedPhotoArr[i];
        [[TZImageManager manager] getPhotoWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info) {
            if (photo) [photos addObject:photo];
            if (info) [infoArr addObject:info];
            if (_isSelectOriginalPhoto) [assets addObject:model.asset];
            if (photos.count < _selectedPhotoArr.count) return;
            
            if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:)]) {
                [imagePickerVc.pickerDelegate imagePickerController:imagePickerVc didFinishPickingPhotos:photos sourceAssets:assets];
            }
            if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:infos:)]) {
                [imagePickerVc.pickerDelegate imagePickerController:imagePickerVc didFinishPickingPhotos:photos sourceAssets:assets infos:infoArr];
            }
            if (imagePickerVc.didFinishPickingPhotosHandle) {
                imagePickerVc.didFinishPickingPhotosHandle(photos,assets);
            }
            if (imagePickerVc.didFinishPickingPhotosWithInfosHandle) {
                imagePickerVc.didFinishPickingPhotosWithInfosHandle(photos,assets,infoArr);
            }
            [imagePickerVc hideProgressHUD];
        }];
    }
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZAssetCell" forIndexPath:indexPath];
    TZAssetModel *model = _photoArr[indexPath.row];
    cell.model = model;
    typeof(cell) weakCell = cell;
    cell.didSelectPhotoBlock = ^(BOOL isSelected) {
        // 1. cancel select / 取消选择
        if (isSelected) {
            weakCell.selectPhotoButton.selected = NO;
            model.isSelected = NO;
            [self.selectedPhotoArr removeObject:model];
            [self refreshBottomToolBarStatus];
        } else {
            // 2. select:check if over the maxImagesCount / 选择照片,检查是否超过了最大个数的限制
            TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
            if (self.selectedPhotoArr.count < imagePickerVc.maxImagesCount) {
                weakCell.selectPhotoButton.selected = YES;
                model.isSelected = YES;
                [self.selectedPhotoArr addObject:model];
                [self refreshBottomToolBarStatus];
            } else {
                [imagePickerVc showAlertWithTitle:[NSString stringWithFormat:@"你最多只能选择%zd张照片",imagePickerVc.maxImagesCount]];
            }
        }
        [UIView showOscillatoryAnimationWithLayer:_numberImageView.layer type:TZOscillatoryAnimationToSmaller];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TZAssetModel *model = _photoArr[indexPath.row];
    if (model.type == TZAssetModelMediaTypeVideo) {
        if (_selectedPhotoArr.count > 0) {
            TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
            [imagePickerVc showAlertWithTitle:@"选择照片时不能选择视频"];
        } else {
            TZVideoPlayerController *videoPlayerVc = [[TZVideoPlayerController alloc] init];
            videoPlayerVc.model = model;
            [self.navigationController pushViewController:videoPlayerVc animated:YES];
        }
    } else {
        TZPhotoPreviewController *photoPreviewVc = [[TZPhotoPreviewController alloc] init];
        photoPreviewVc.photoArr = _photoArr;
        photoPreviewVc.currentIndex = indexPath.row;
        [self pushPhotoPrevireViewController:photoPreviewVc];
    }
}

#pragma mark - Private Method

- (void)refreshBottomToolBarStatus {
    _previewButton.enabled = self.selectedPhotoArr.count > 0;
    _okButton.enabled = self.selectedPhotoArr.count > 0;
    
    _numberImageView.hidden = _selectedPhotoArr.count <= 0;
    _numberLable.hidden = _selectedPhotoArr.count <= 0;
    _numberLable.text = [NSString stringWithFormat:@"%zd",_selectedPhotoArr.count];
    
    _originalPhotoButton.enabled = _selectedPhotoArr.count > 0;
    _originalPhotoButton.selected = (_isSelectOriginalPhoto && _originalPhotoButton.enabled);
    _originalPhotoLable.hidden = (!_originalPhotoButton.isSelected);
    if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
}

- (void)pushPhotoPrevireViewController:(TZPhotoPreviewController *)photoPreviewVc {
    photoPreviewVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    photoPreviewVc.selectedPhotoArr = self.selectedPhotoArr;
    photoPreviewVc.returnNewSelectedPhotoArrBlock = ^(NSMutableArray *newSelectedPhotoArr,BOOL isSelectOriginalPhoto) {
        _selectedPhotoArr = newSelectedPhotoArr;
        _isSelectOriginalPhoto = isSelectOriginalPhoto;
        [_collectionView reloadData];
        [self refreshBottomToolBarStatus];
    };
    photoPreviewVc.okButtonClickBlock = ^(NSMutableArray *newSelectedPhotoArr,BOOL isSelectOriginalPhoto){
        _selectedPhotoArr = newSelectedPhotoArr;
        _isSelectOriginalPhoto = isSelectOriginalPhoto;
        [self okButtonClick];
    };
    [self.navigationController pushViewController:photoPreviewVc animated:YES];
}

- (void)getSelectedPhotoBytes {
    [[TZImageManager manager] getPhotosBytesWithArray:_selectedPhotoArr completion:^(NSString *totalBytes) {
        _originalPhotoLable.text = [NSString stringWithFormat:@"(%@)",totalBytes];
    }];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com