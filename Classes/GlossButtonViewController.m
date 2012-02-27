//
//  GlossButtonViewController.m
//  GlossButton
//
//  Created by Chris Jones on 10/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlossButtonViewController.h"

@implementation GlossButtonViewController

@synthesize	button1=_button1;
@synthesize	button2=_button2;
@synthesize	button3=_button3;
@synthesize	button4=_button4;
@synthesize	button5=_button5;
@synthesize	button6=_button6;
@synthesize	button7=_button7;
@synthesize	button8=_button8;
@synthesize	button9=_button9;
@synthesize	button0=_button0;
@synthesize	buttonPoint=_buttonPoint;

@synthesize	buttonPlus=_buttonPlus;
@synthesize	buttonMinus=_buttonMinus;
@synthesize	buttonDivide=_buttonDivide;
@synthesize	buttonMultiply=_buttonMultiply;
@synthesize	buttonEquals=_buttonEquals;
@synthesize	buttonClear=_buttonClear;
@synthesize	buttonPlusminus=_buttonPlusminus;

@synthesize buttons=_buttons;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (CustomButton *)customButtonWithFrame:(CGRect)frame title:(NSString *)title
{
	return [CustomButton customButtonWithFrame:frame title:title target:self selector:@selector(buttonTapped:)];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	//background
	UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg_calc.png"]];
	self.view.backgroundColor = background;
	[background release];
	
	CGFloat height=50;
	CGFloat width=80;
	CGFloat col1=0;
	CGFloat row1=245;
	CGFloat row0=190;
	
	CGFloat spacingy=3;
	CGFloat row2=row1+height+spacingy;
	CGFloat row3=row2+height+spacingy;
	CGFloat row4=row3+height+spacingy;
	CGFloat spacingx=0;
	CGFloat col2=col1+width+spacingx;
	CGFloat col3=col2+width+spacingx;
	CGFloat col4=col3+width+spacingx;
	
	self.button7 = [self customButtonWithFrame:CGRectMake(col1,row1, width, height) title:@"7"];
	self.button8 = [self customButtonWithFrame:CGRectMake(col2,row1, width, height) title:@"8"];
	self.button9 = [self customButtonWithFrame:CGRectMake(col3,row1, width, height) title:@"9"];

	self.button4 = [self customButtonWithFrame:CGRectMake(col1,row2, width, height) title:@"4"];
	self.button5 = [self customButtonWithFrame:CGRectMake(col2,row2, width, height) title:@"5"];
	self.button6 = [self customButtonWithFrame:CGRectMake(col3,row2, width, height) title:@"6"];

	self.button1 = [self customButtonWithFrame:CGRectMake(col1,row3, width, height) title:@"1"];
	self.button2 = [self customButtonWithFrame:CGRectMake(col2,row3, width, height) title:@"2"];
	self.button3 = [self customButtonWithFrame:CGRectMake(col3,row3, width, height) title:@"3"];

	self.button0 = [self customButtonWithFrame:CGRectMake(col1,row4, width*2, height) title:@"0"];

	self.buttonPoint = [self customButtonWithFrame:CGRectMake(col3,row4, width, height) title:@"."];
	self.buttonEquals = [self customButtonWithFrame:CGRectMake(col4,row3, width, height*2) title:@"="];
	self.buttonPlus = [self customButtonWithFrame:CGRectMake(col4,row2, width, height) title:@"-"];
	self.buttonMinus = [self customButtonWithFrame:CGRectMake(col4,row1, width, height) title:@"+"];
	
	self.buttonMultiply = [self customButtonWithFrame:CGRectMake(col4,row0, width, height) title:@"×"];
	self.buttonDivide = [self customButtonWithFrame:CGRectMake(col3,row0, width, height) title:@"÷"];
	self.buttonPlusminus = [self customButtonWithFrame:CGRectMake(col2,row0, width, height) title:@"±"];
	self.buttonClear = [self customButtonWithFrame:CGRectMake(col1,row0, width, height) title:@"AC"];


	self.buttonEquals.backgroundColor = [UIColor colorWithHue:0.075f saturation:0.9f brightness:0.96f alpha:1.0f];
	self.buttonPlus.backgroundColor = [UIColor colorWithHue:0.058f saturation:0.26f brightness:0.42f alpha:1.0f];
	self.buttonMinus.backgroundColor = [UIColor colorWithHue:0.058f saturation:0.26f brightness:0.42f alpha:1.0f];
	self.buttonMultiply.backgroundColor = [UIColor colorWithHue:0.058f saturation:0.26f brightness:0.42f alpha:1.0f];
	self.buttonDivide.backgroundColor = [UIColor colorWithHue:0.058f saturation:0.26f brightness:0.42f alpha:1.0f];
	self.buttonPlusminus.backgroundColor = [UIColor colorWithHue:0.058f saturation:0.26f brightness:0.42f alpha:1.0f];
	self.buttonClear.backgroundColor = [UIColor colorWithHue:0.058f saturation:0.26f brightness:0.42f alpha:1.0f];
	
	self.buttons = [NSMutableArray arrayWithObjects:
					_button1,                            
					_button2, 
					_button3, 
					_button4,                            
					_button5, 
					_button6, 
					_button7,                            
					_button8, 
					_button9, 
					_button0,                            
					_buttonPoint, 
					_buttonPlus,
					_buttonEquals,
					_buttonMinus,
					_buttonMultiply,
					_buttonClear,
					_buttonPlusminus,
					_buttonDivide,
					nil];
	
    for (CustomButton *button in _buttons) {
        [self.view addSubview:button];
    }

}

- (void)buttonTapped:(id)sender
{
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
