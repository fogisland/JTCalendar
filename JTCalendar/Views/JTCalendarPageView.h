//
//  JTCalendarPageView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendarPage.h"

@interface JTCalendarPageView : UIView<JTCalendarPage>

@property (nonatomic, weak) JTCalendarManager *manager;
@property (nonatomic) NSMutableArray *weeksViews;

@property (nonatomic) NSDate *date;

/*!
 * Must be call if override the class
 */
- (void)commonInit;

@end
