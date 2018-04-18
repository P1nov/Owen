//
//  MyTableViewCell.m
//  Owen
//
//  Created by  P1no on 2018/4/18.
//  Copyright © 2018年  P1no. All rights reserved.
//

#import "MyTableViewCell.h"
#import <objc/runtime.h>

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage111)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage111)];
        _imageView1 = [[UIImageView alloc]init];
        _imageView2 = [[UIImageView alloc]init];
        _imageView1.frame = CGRectMake(5, 5, 100, 100);
        _imageView2.frame = CGRectMake(110, 5, 100, 100);
        [_imageView1 addGestureRecognizer:tap1];
        [_imageView2 addGestureRecognizer:tap2];
        _imageView1.userInteractionEnabled = YES;
        _imageView2.userInteractionEnabled = YES;
//        if (@available(iOS 11.0, *)) {
//            self.userInteractionEnabledWhileDragging = YES;
//        } else {
//
//        }
        [self.contentView addSubview:_imageView1];
        [self.contentView addSubview:_imageView2];
    }
    return self;
}

-(void)tapImage111{
    [self.delegate clickImageRespond];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
