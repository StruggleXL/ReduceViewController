//
//  HttpRequestHeader.h
//  DRMonline
//
//  Created by imac on 16/8/10.
//  Copyright © 2016年 Eric. All rights reserved.
//

#ifndef HttpRequestHeader_h
#define HttpRequestHeader_h

//内网环境
#define DRMONLINE_BUILD_FOR_TEST

//测试环境
//#define DRMONLINE_BUILD_FOR_BATE

//生产环境
//#define DRMONLINE_BUILD_FOR_RELEASE

//如果没有打开任何环境那就是生产环境
#if !defined DRMONLINE_BUILD_FOR_TEST && !defined DRMONLINE_BUILD_FOR_RELEASE && !defined DRMONLINE_BUILD_FOR_BATE
#define DRMONLINE_BUILD_FOR_RELEASE
#endif

#ifdef DRMONLINE_BUILD_FOR_TEST
//IP地址
#define kServerURL @"http://netschool.deruimu.com/"
//分享地址
#define kShareServerURL @"http://netschool.deruimu.com/"
#endif

#ifdef DRMONLINE_BUILD_FOR_BATE
//IP地址
#define kServerURL @""
#endif

#ifdef DRMONLINE_BUILD_FOR_RELEASE
//IP地址
#define kServerURL @"http://online.deruimu.com/"
//分享地址
#define kShareServerURL @"http://m.deruimu.com/"
#endif



#endif /* HttpRequestHeader_h */
