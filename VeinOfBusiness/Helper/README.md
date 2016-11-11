README
商脉APP集成文件使用说明

1.网络请求
引用
#import "RestfulAPIRequestTool.h"

使用示例:

/**
* GetNewRegistersInContacts 存在RouteInfo.plist里面链接的名称
* dic 网络请求参数及数据, 一一列举
* arr 网络请求参数名数组, 全部列举
*/

NSArray *arr = @[@"timestamp"];
NSDictionary *dic = @{@"timestamp": @"2106-11-11"};

 [RestfulAPIRequestTool routeName:@"GetNewRegistersInContacts" requestModel:dic useKeys:arr success:^(id json) {
//成功
} failure:^(id errorJson) {
//失败
        }];


RouteInfo.plist文件格式
<dict>
        <key>routeMethod</key> //方法类型 GET POST DELETE 等等
        <string>GET</string>
        <key>routeName</key>  //此网络请求的名字
        <string>get_contract_by_id</string>
        <key>routeURL</key>   //网络请求的链接
        <string></string>
    </dict>

2.图片请求及缓存
引用
#import "UIImageView+DLGetWebImage.h"

使用示例

/**
* imageUrl 图片链接, 尚未规定链接规范
* 请求网络图片并缓存 ,下次使用本地缓存图片
*/
UIImageView *imageView = [UIImageView new];
[imageView dlGetSpecialSizedWebImageWithString:imageUrl placeholderImage:nil];


3.本地数据缓存

使用 创建继承自 JKDBModel 的类, JKDBModel里面有详细的使用说明, 直接使用

