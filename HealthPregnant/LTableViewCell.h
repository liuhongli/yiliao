//
//  LTableViewCell.h
//  tableview
//
//  Created by mac on 14-9-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTableViewCell : UITableViewCell{
    BOOL			m_checked;
    UIImageView*	m_checkImageView;
    
}
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView*	m_checkImageView;

- (void)setChecked:(BOOL)checked;
//计算cell的展开的高度
+ (CGFloat)cellHeight:(NSString *)content;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
