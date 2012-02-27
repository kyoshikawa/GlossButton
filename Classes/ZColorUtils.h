//
//  ZColorUtils.h
//
//  Created by Kaz Yoshikawa on 12/31/09.
//  Copyright 2009 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ZRGBA_t__
#define __ZRGBA_t__
typedef struct ZRGBA
{
	CGFloat r;
	CGFloat g;
	CGFloat b;
	CGFloat a;
} ZRGBA;
#endif

#ifndef __ZHSBA_t__
#define __ZHSBA_t__
typedef struct ZHSBA
{
	CGFloat h;
	CGFloat s;
	CGFloat b;
	CGFloat a;
} ZHSBA;
#endif

extern void RGBtoHSB(CGFloat r, CGFloat g, CGFloat b, CGFloat *h, CGFloat *s, CGFloat *v);
extern void HSBtoRGB(CGFloat h, CGFloat s, CGFloat v, CGFloat *r, CGFloat *g, CGFloat *b);
extern void CGColorToRGBA(CGColorRef colorRef, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a);
extern void CGColorToHSB(CGColorRef colorRef, CGFloat *h, CGFloat *s, CGFloat *v, CGFloat *a);
extern void CGColorToRGBA8(CGColorRef colorRef, unsigned char *r, unsigned char *g, unsigned char *b, unsigned char *a);
extern CGColorRef CGColorFromZRGBA(ZRGBA aRGBA);
extern UIColor *UIColorFromZRGBA(ZRGBA aRGBA);
extern ZRGBA ZRGBAFromCGColor(CGColorRef colorRef);
extern ZHSBA ZHSBAFromCGColor(CGColorRef colorRef);
extern ZRGBA ZRGBAMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
extern ZRGBA ZRGBAFromHSB(CGFloat h, CGFloat s, CGFloat v, CGFloat a);
extern ZRGBA ZRGBAFromZHSBA(ZHSBA hsba);
extern ZHSBA ZHSBAFromRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
extern ZHSBA ZHSBAFromZRGBA(ZRGBA rgba);
extern bool ZRGBAEqualToZRGBA(ZRGBA aRGBA1, ZRGBA aRGBA2);
extern NSValue *ZRGBAValue(ZRGBA aRGBA);
extern ZRGBA ZRGBAFromValue(NSValue *aValue);
extern ZRGBA ZRGBAFromString(NSString *aString);

#ifdef __cplusplus
}
#endif

