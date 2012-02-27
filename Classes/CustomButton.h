//
//  CustomButton.h
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

//	(Feb 2012) chnaged by Kaz Yoshikawa
//	1.	remove label, then use standard title instead
//	2.	remove touch event hundling, use - addTarget:action:forControlEvents: or IB
//	3.	implement blackgroundColor to be the color of button which can be
//		specified by Interface Builder.


#import <UIKit/UIKit.h>

@interface CustomButton : UIButton {
    BOOL _selected;
	BOOL _toggled;
	int _buttonStyle;
	NSValue *_hsbValue;
}
@property  int buttonStyle;
@property  BOOL selected;
@property  BOOL toggled;

+ (id)customButtonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector;

@end
