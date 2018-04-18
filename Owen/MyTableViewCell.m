//
//  MyTableViewCell.m
//  Owen
//
//  Created by  P1no on 2018/4/18.
//  Copyright © 2018年  P1no. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _imageView1 = [[UIImageView alloc]init];
        _imageView2 = [[UIImageView alloc]init];
        _imageView1.frame = CGRectMake(5, 5, 40, 40);
        _imageView2.frame = CGRectMake(50, 5, 40, 40);
        [self.contentView addSubview:_imageView1];
        [self.contentView addSubview:_imageView2];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
