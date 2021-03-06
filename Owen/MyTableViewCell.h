//
//  MyTableViewCell.h
//  Owen
//
//  Created by  P1no on 2018/4/18.
//  Copyright © 2018年  P1no. All rights reserved.
//

#import <UIKit/UIKit.h>
//
@protocol ClickImageDelegate<NSObject>

-(void)clickImageRespond;

@end

@interface MyTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *imageView1;

@property(nonatomic, strong) UIImageView *imageView2;

@property(nonatomic, weak) id<ClickImageDelegate> delegate;

@end
