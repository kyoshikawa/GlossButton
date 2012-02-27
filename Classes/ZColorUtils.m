//
//  ZColorUtils.m
//
//  Created by Kaz Yoshikawa on 12/31/09.
//  Copyright 2009 Electricwoods LLC. All rights reserved.
//

#import "ZColorUtils.h"

#ifdef __cplusplus
extern "C" {
#endif

void RGBtoHSB(CGFloat r, CGFloat g, CGFloat b, CGFloat *h, CGFloat *s, CGFloat *v)
{
	assert(h);
	assert(s);
	assert(v);

    CGFloat min, max, delta;
    min = r;
    if (g < min) min = g;
    if (b < min) min = b;
    max = r;
    if (g > max) max = g;
    if (b > max) max = b;
    *v = max;										// v
    delta = max - min;
    if(max != 0.0f) *s = delta / max;				// s
    else {											// r,g,b=0, s=0, v: undefined
		*s = 0.0f;
		*h = 0.0f;
		return;
    }
    if (r == max) *h = (g - b) / delta;				// between yellow & magenta
    else if (g == max) *h = 2.0f + (b - r) / delta;	// between cyan & yellow
    else *h = 4.0f + (r - g) / delta;				// between magenta & cyan
    *h /= 6.0f;										// 0 -> 1
    if (*h < 0.0f) *h += 1.0f;
}

void HSBtoRGB(CGFloat h, CGFloat s, CGFloat v, CGFloat *r, CGFloat *g, CGFloat *b)
{
	assert(r);
	assert(g);
	assert(b);

    CGFloat f, p, q, t;
    if (s == 0) { 									// grey
		*r = *g = *b = v;
		return;
    }
    if (h < 0.0f) h = 0.0f;
    h *= 6.0f;
    int sector = ((int)h) % 6;
    f = h - (CGFloat)sector;						// factorial part of h
    p = v * (1 - s);
    q = v * (1 - s * f);
    t = v * (1 - s * (1-f));
    switch(sector) {
	case 0: default: *r = v; *g = t; *b = p; break;
	case 1: *r = q; *g = v; *b = p; break;
	case 2: *r = p; *g = v; *b = t; break;
	case 3: *r = p; *g = q; *b = v; break;
	case 4: *r = t; *g = p; *b = v; break;
	case 5: *r = v; *g = p; *b = q; break;
    }
}

void CGColorToRGBA(CGColorRef colorRef, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a)
{
	assert(colorRef);
	assert(r);
	assert(g);
	assert(b);
	assert(a);;

	switch (CGColorSpaceGetModel(CGColorGetColorSpace(colorRef))) {
	case kCGColorSpaceModelRGB: {
			assert(CGColorGetNumberOfComponents(colorRef) == 4);
			const CGFloat *components = CGColorGetComponents(colorRef);
			*r = components[0];
			*g = components[1];
			*b = components[2];
			*a = components[3];
		}
		break;
	case kCGColorSpaceModelMonochrome: {
			assert(CGColorGetNumberOfComponents(colorRef) == 2);
			const CGFloat *components = CGColorGetComponents(colorRef);
			*r = components[0];
			*g = components[0];
			*b = components[0];
			*a = components[1];
		}
		break;
	default:
		NSLog(@"Unexpected color space model: %d", CGColorSpaceGetModel(CGColorGetColorSpace(colorRef)));
		assert(NO);
	}
}

void CGColorToHSB(CGColorRef colorRef, CGFloat *h, CGFloat *s, CGFloat *v, CGFloat *a)
{
	assert(colorRef);
	assert(h);
	assert(s);
	assert(v);

	CGFloat r, g, b;
	CGColorToRGBA(colorRef, &r, &g, &b, a);
	RGBtoHSB(r, g, b, h, s, v);
}

CGColorRef CGColorFromZRGBA(ZRGBA aRGBA)
{
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGFloat components[] = {aRGBA.r, aRGBA.g, aRGBA.b, aRGBA.a};
	CGColorRef colorRef = CGColorCreate(colorSpaceRef, components);
	CGColorSpaceRelease(colorSpaceRef);
	[(id)colorRef autorelease];
	return colorRef;
}

UIColor *UIColorFromZRGBA(ZRGBA aRGBA)
{
	return [UIColor colorWithRed:aRGBA.r green:aRGBA.g blue:aRGBA.b alpha:aRGBA.a];
}

ZRGBA ZRGBAFromCGColor(CGColorRef colorRef)
{
	ZRGBA rgba;
	CGColorToRGBA(colorRef, &rgba.r, &rgba.g, &rgba.b, &rgba.a);
	return rgba;
}

ZHSBA ZHSBAFromCGColor(CGColorRef colorRef)
{
	ZHSBA hsba;
	CGColorToHSB(colorRef, &hsba.h, &hsba.s, &hsba.b, &hsba.a);
	return hsba;
}


ZRGBA ZRGBAMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
	ZRGBA rgba = {r, g, b, a};
	return rgba;
}

ZRGBA ZRGBAFromHSB(CGFloat h, CGFloat s, CGFloat v, CGFloat a)
{
	ZRGBA rgba;
	HSBtoRGB(h, s, v, &rgba.r, &rgba.g, &rgba.b);
	rgba.a = a;
	return rgba;
}

ZRGBA ZRGBAFromZHSBA(ZHSBA hsba)
{
	ZRGBA rgba;
	HSBtoRGB(hsba.h, hsba.s, hsba.b, &rgba.r, &rgba.g, &rgba.b);
	rgba.a = hsba.a;
	return rgba;
}

ZHSBA ZHSBAFromZRGBA(ZRGBA rgba)
{
	ZHSBA hsba;
	RGBtoHSB(rgba.r, rgba.g, rgba.b, &hsba.h, &hsba.s, &hsba.a);
	hsba.a = rgba.a;
	return hsba;
}

ZHSBA ZHSBAFromRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
	ZHSBA hsba;
	RGBtoHSB(r, g, b, &hsba.h, &hsba.s, &hsba.b);
	return hsba;
} 

bool ZRGBAEqualToZRGBA(ZRGBA aRGBA1, ZRGBA aRGBA2)
{
	return (aRGBA1.r == aRGBA2.r &&
			aRGBA1.g == aRGBA2.g &&
			aRGBA1.b == aRGBA2.b &&
			aRGBA1.a == aRGBA2.a);
}

NSValue *ZRGBAValue(ZRGBA aRGBA)
{
	return [NSValue value:&aRGBA withObjCType:@encode(ZRGBA)];
}

ZRGBA ZRGBAFromValue(NSValue *aValue)
{
	assert(aValue && [aValue isKindOfClass:[NSValue class]]);

	ZRGBA rgba;
	[aValue getValue:&rgba];
	return rgba;
}

#ifdef __cplusplus
}
#endif





