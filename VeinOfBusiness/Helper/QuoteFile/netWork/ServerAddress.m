//
//  ServerAddress.m
//  friendChains
//
//  Created by tom on 15/11/12.
//  Copyright © 2015年 donler. All rights reserved.
//

#import "ServerAddress.h"

static ServerAddress* server = nil;
static ServerAddress* imgServer = nil;

@interface ServerAddress ()
@property (nonatomic,strong) NSString* serverAddress;
@property (nonatomic, strong) NSString* imgServerAddress;
@end

@implementation ServerAddress

+ (NSString*)serverAddress
{
    if (server == nil) {
        server = [ServerAddress new];
    }
    return [server getServerAddress];
}

+ (NSString *)imgServerAddress
{
    if (imgServer == nil) {
        imgServer = [ServerAddress new];
    }
    return [server getImgServerAddress];
}

- (NSString *)getServerAddress
{
    if (!self.serverAddress) {
        self.serverAddress= @"http://123.196.117.247:8090/index.php";
    }
    return self.serverAddress;
}

- (NSString *)getImgServerAddress
{
    if (!self.imgServerAddress) {
        self.imgServerAddress = @"http://123.56.232.240:3003";
    }
    return self.imgServerAddress;
}
@end
