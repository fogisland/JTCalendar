//
//  JTCalendarDayView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendarDay.h"

@interface JTCalendarDayView : UIView<JTCalendarDay>

@property (nonatomic, weak) JTCalendarManager *manager;

@property (nonatomic) NSDate *date;

@property (nonatomic, readonly) UIView *circleView;
@property (nonatomic, readonly) UIView *dotView;
@property (nonatomic, readonly) UILabel *textLabel;

@property (nonatomic, readonly) UIView *backCircleView;
@property (nonatomic, readonly) UILabel *backTopTextLabel;
@property (nonatomic, readonly) UIView *backSeperateLine;
@property (nonatomic, readonly) UILabel *backBottomTextLabel;
@property (nonatomic, readonly) UIView *backDotView;

@property (nonatomic) CGFloat circleRatio;
@property (nonatomic) CGFloat dotRatio;
@property (nonatomic) CGFloat backDotRatio;

@property (nonatomic) BOOL isFromAnotherMonth;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

@end
