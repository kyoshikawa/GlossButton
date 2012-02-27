//
//  CustomButton.m
//
//  Created by Chris Jones.
//  Copyright 2011 Chris Jones. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


//	Note:
//	Kaz Yoshikawa made some changes for the usage of typical push button,
//	in instead of being specialized for cool caluculator button.
//	In order to specify button color from Interface Builder, you can specify
//	background color for the button.

#import "CustomButton.h"
#import "Common.h"
#import <QuartzCore/QuartzCore.h>
#import "ZColorUtils.h"


@interface CustomButton ()
@property (retain) NSValue *hsbValue;
@property (readonly) ZHSBA HSBA;
@end

#define kButtonRadius 6.0

@implementation CustomButton
@synthesize selected = _selected;
@synthesize toggled=_toggled;
@synthesize buttonStyle = _buttonStyle;
@synthesize hsbValue = _hsbValue;

+ (id)customButtonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector;
{
	CustomButton *button = [[[CustomButton alloc] initWithFrame:frame] autorelease];
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:title forState:UIControlStateNormal];
	return button;
}

-(id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super initWithCoder:decoder])) {
		self.opaque = NO;
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.opaque = NO;
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	if (!self.hsbValue) {
		CGFloat r, g, b, a;
		[self.backgroundColor getRed:&r green:&g blue:&b alpha:&a];
		ZHSBA hsba = ZHSBAFromRGBA(r, g, b, a);
		self.hsbValue = [NSValue value:&hsba withObjCType:@encode(ZHSBA)];
		super.backgroundColor = [UIColor clearColor];
	}
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	ZHSBA hsba = self.HSBA;

    CGFloat actualBrightness = hsba.b;
    if (self.selected) {
        actualBrightness -= 0.10;
    }   

    CGColorRef blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    CGColorRef highlightStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7].CGColor;
    CGColorRef highlightStop = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0].CGColor;

	CGColorRef outerTop = [UIColor colorWithHue:hsba.h saturation:1.0*hsba.s brightness:1.0*hsba.b alpha:1.0].CGColor;
    CGColorRef outerBottom = [UIColor colorWithHue:hsba.h saturation:1.0*hsba.s brightness:0.80*actualBrightness alpha:1.0].CGColor;
	
    CGFloat outerMargin = 1.0f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);            
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 6.0);
	
    // Draw gradient for outer path
	CGContextSaveGState(context);
	CGContextAddPath(context, outerPath);
	CGContextClip(context);
	drawLinearGradient(context, outerRect, outerTop, outerBottom);

	CGContextRestoreGState(context);
	    
	if (!self.highlighted) {

		CGRect highlightRect = CGRectInset(outerRect, 1.0f, 1.0f);
		CGMutablePathRef highlightPath = createRoundedRectForRect(highlightRect, 6.0);

		CGContextSaveGState(context);
		CGContextAddPath(context, outerPath);
		CGContextAddPath(context, highlightPath);
		CGContextEOClip(context);

		drawLinearGradient(context, CGRectMake(outerRect.origin.x, outerRect.origin.y, outerRect.size.width, outerRect.size.height/3), highlightStart, highlightStop);
		CGContextRestoreGState(context);
		
		drawCurvedGloss(context, outerRect, 180);
		CFRelease(highlightPath);

	}
	else {
		//reverse non-curved gradient when pressed
		CGContextSaveGState(context);
		CGContextAddPath(context, outerPath);
		CGContextClip(context);
		drawLinearGloss(context, outerRect, TRUE);		
		CGContextRestoreGState(context);
		
	}
	if (!self.toggled) {
		//bottom highlight
		CGRect highlightRect2 = CGRectInset(self.bounds, 1.0f, 1.0f);
		CGMutablePathRef highlightPath2 = createRoundedRectForRect(highlightRect2, 6.0);
		
		CGContextSaveGState(context);
		CGContextSetLineWidth(context, 0.5);
		CGContextAddPath(context, highlightPath2);
		CGContextAddPath(context, outerPath);
		CGContextEOClip(context);
		drawLinearGradient(context, CGRectMake(self.bounds.origin.x, self.bounds.size.height-self.bounds.size.height/3, self.bounds.size.width, self.bounds.size.height/3), highlightStop, highlightStart);

		CGContextRestoreGState(context);
		CFRelease(highlightPath2);
	}
    else {
		//toggle marker
		CGRect toggleRect= CGRectInset(self.bounds, 1.0f, 1.0f);
		CGMutablePathRef togglePath= createRoundedRectForRect(toggleRect, 8.0);

		CGContextSaveGState(context);
		CGContextSetLineWidth(context, 3.5);
		CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
		CGContextAddPath(context, togglePath);
		CGContextStrokePath(context);
		CGContextRestoreGState(context);
		CFRelease(togglePath);
	}
    // Stroke outer path
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, blackColor);
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);

    CFRelease(outerPath);
}

- (BOOL)toggled {
	return _toggled;
}

-(void)setToggled:(BOOL)toggled {
    if (_toggled == toggled) return;    
    _toggled = toggled;
    [self setNeedsDisplay];
}

- (BOOL)selected {
	return _selected;
}

-(void)setSelected:(BOOL)selected {
    if (_selected == selected) return;    
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)setHighlighted: (BOOL)highlighted {
    BOOL old = self.highlighted;
    [super setHighlighted: highlighted];
    
    if (old != highlighted) {
        [self setNeedsDisplay];
	}
}

- (void)dealloc {
	self.hsbValue = nil;
    [super dealloc];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
	ZHSBA hsba;
	CGColorToHSB(backgroundColor.CGColor, &hsba.h, &hsba.s, &hsba.b, &hsba.a);
	self.hsbValue = [NSValue value:&hsba withObjCType:@encode(ZHSBA)];
	[super setBackgroundColor:[UIColor clearColor]];
}

- (ZHSBA)HSBA {
	ZHSBA hsba = {0, 0, 0, 1};
	if (self.hsbValue) {
		[self.hsbValue getValue:&hsba];
	}
	return hsba;
}


@end
