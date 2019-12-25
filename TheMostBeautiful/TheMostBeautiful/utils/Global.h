//
//  Global.h
//  TheMostBeautiful
//
//  Created by Tony on 19/11/21.
//  Copyright © 2019年 Tony. All rights reserved.
//

#ifndef Global_h
#define Global_h

#define kWebServer @"http://bookapi.zhiyuanxz.cn/book" //api    正式环境


#define kPathWebServer(path) ({[NSString stringWithFormat:@"%@%@",kWebServer,path];})

#endif /* Global_h */
