//
//  RedEnvelopeViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RedEnvelopeViewController.h"

@interface RedEnvelopeViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation RedEnvelopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionWidth.constant = DLScreenWidth / (375 / 275.0);
    
    self.collectionHeight.constant = self.collectionWidth.constant / (309 / 181.0);
    
    //轻易不要动这行代码!!! 写的太牛逼了!!!
    self.collectionTop.constant = ((DLScreenHeight - self.collectionHeight.constant) + (DLScreenHeight / (667 / (254.0 - 208.0)))) / 2.0  + ((DLScreenHeight / (667 / 181.0) - self.collectionHeight.constant)) / 2.0;
    self.myLabel.text = @"\n你的红包库空空的\n\n\n快去阅读资讯,收获红包吧\n";
    
}




- (IBAction)returnButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
