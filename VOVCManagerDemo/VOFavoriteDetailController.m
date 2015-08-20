//
//  VOFavoriteDetailController.m
//  VOVCManagerDemo
//
//  Created by Valo on 15/5/8.
//  Copyright (c) 2015年 valo. All rights reserved.
//

#import "VOFavoriteDetailController.h"

@interface VOFavoriteDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation VOFavoriteDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.favText) {
        self.label.text = self.favText;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
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
