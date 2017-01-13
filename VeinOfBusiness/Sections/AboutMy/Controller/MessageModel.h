//
//  MessageModel.h
//  VeinOfBusiness
//
//  Created by sense on 16/11/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,copy) NSString *msgId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *addTime;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *summary;


@end
