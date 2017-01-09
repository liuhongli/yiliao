//
//  LTableViewCell.m
//  tableview
//
//  Created by mac on 14-9-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LTableViewCell.h"


#define kContentWidth 218

@implementation LTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creat];
    }
    return self;
}

- (void)creat{

    if (self.m_checkImageView == nil)
    {
        self.m_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"空白圈"]];
       self. m_checkImageView.frame = CGRectMake(10, self.height/2-10, 20, 20);
        self.m_checkImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.m_checkImageView];
    }
    if (self.titleLabel == nil) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 00, kScreenWidth - 70, self.height-20)];
        
//        self.titleLabel.lineBreakMode =UILineBreakModeMiddleTruncation;
//        self.titleLabel.numberOfLines = 10;

        [self addSubview:self.titleLabel];
    }
}



- (void)setChecked:(BOOL)checked{
    if (checked)
	{
		self.m_checkImageView.image = [UIImage imageNamed:@"选择"];
		self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
	}
	else
	{
		self.m_checkImageView.image = [UIImage imageNamed:@"空白圈"];
		self.backgroundView.backgroundColor = [UIColor whiteColor];
	}
	m_checked = checked;
    
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight:(NSString *)content {
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(kContentWidth, 1000)];
    float height = size.height;
    
    return height + 50;
}


@end

