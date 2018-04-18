//
//  ViewController.m
//  Owen
//
//  Created by  P1no on 2018/4/18.
//  Copyright © 2018年  P1no. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "SecondViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,ClickImageDelegate>

//存放任务的数组
@property (nonatomic, strong) NSMutableArray *saveTaskMarr;

//最大任务数（超过最大任务数的任务就停止执行）
@property (nonatomic, assign) NSInteger maxTasksNumber;

//任务执行的代码块
@property (nonatomic, copy) SaveFuncBlock saveFuncBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _saveTaskMarr = [NSMutableArray array];
    _myTableView = [[UITableView alloc]init];
    _myTableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    self.maxTasksNumber = 12;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(wakeRunloop) userInfo:nil repeats:YES];
    [self addRunloopObserver];
    [timer fire];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 399;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(cell == nil){
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.delegate = self;
//    [cell.imageView1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageRespond)]];
//    cell.delegate = self;
//    [self addImageToCell:cell];
    //添加任务到数组
    __weak typeof(self) weakSelf = self;
    [self addTasks:^{
        //下载图片的任务
        [weakSelf addImageToCell:cell];
    }];
    return cell;
}

-(void)clickImageRespond{
    SecondViewController *svc = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}

-(void)addTask:(SaveFuncBlock)block{
    [self.saveTaskMarr addObject:block];
    //超过每次最多执行的任务数就移出当前数组
    if (self.saveTaskMarr.count > self.maxTasksNumber) {
        
        [self.saveTaskMarr removeObjectAtIndex:0];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

-(void)addImageToCell:(MyTableViewCell *)cell{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img5.duitang.com/uploads/item/201312/14/20131214173346_iVKdT.jpeg"]]];
    cell.imageView1.image = image;
    cell.imageView2.image = image;
}

-(void)addRunloopObserver{
    //获取当前的RunLoop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个centext
    CFRunLoopObserverContext context = {
        0,
        ( __bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    //定义一个观察者
    static CFRunLoopObserverRef defaultModeObsever;
    //创建观察者
    defaultModeObsever = CFRunLoopObserverCreate(NULL,
                                                 kCFRunLoopBeforeWaiting,
                                                 YES,
                                                 NSIntegerMax - 999,
                                                 &Callback,
                                                 &context
                                                 );
    
    //添加当前RunLoop的观察者
    CFRunLoopAddObserver(runloop, defaultModeObsever, kCFRunLoopDefaultMode);
    //c语言有creat 就需要release
    CFRelease(defaultModeObsever);
}

//添加任务进数组保存
-(void)addTasks:(SaveFuncBlock)taskBlock{
    
    [self.saveTaskMarr addObject:taskBlock];
    //超过每次最多执行的任务数就移出当前数组
    if (self.saveTaskMarr.count > self.maxTasksNumber) {
        
        [self.saveTaskMarr removeObjectAtIndex:0];
    }
    
}

-(void)wakeRunloop{}

//MARK: 回调函数
//定义一个回调函数  一次RunLoop来一次
static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    ViewController * vcSelf = (__bridge ViewController *)(info);
    
    if (vcSelf.saveTaskMarr.count > 0) {
        
        //获取一次数组里面的任务并执行
        SaveFuncBlock funcBlock = vcSelf.saveTaskMarr.firstObject;
        funcBlock();
        [vcSelf.saveTaskMarr removeObjectAtIndex:0];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
