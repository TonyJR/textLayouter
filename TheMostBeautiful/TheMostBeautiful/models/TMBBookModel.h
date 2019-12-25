//
//  TMBBookModel.h
//  TheMostBeautiful
//
//  Created by Tony on 19/11/17.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TMBBookTypeUnknow = 0,
    TMBBookTypeNormal = 1,
} TMBBookType;

@interface TMBBookModel : NSObject

@property (nonatomic,copy) NSString *bookID;
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,assign) TMBBookType bookType;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,strong) NSDate *createDate;
@property (nonatomic,strong) NSDate *ctime;
@property (nonatomic,strong) NSDate *mtime;
@property (nonatomic,assign) NSUInteger pageCount;


@end

/*
 author = "\U4f5c\U8005\U540d\U79f0";
 "c_date" = "2019-11-13 14:08:21";
 cover = "&lt;xml&gt;\U5c01\U9762\U6570\U636e&lt;/xml&gt;";
 ctime = "2019-11-13 14:08:21";
 id = 11;
 mtime = "2019-11-13 14:08:21";
 pageCount = 1;
 subtitle = "\U8fd9\U91cc\U662f\U526f\U6807\U9898";
 title = "\U6d4b\U8bd5\U4e66\U540d";
 type = 1;
 "user_id" = 1;
 */
