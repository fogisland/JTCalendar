//
//  JTCalendarDayView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarDayView.h"

#import "JTCalendarManager.h"

@implementation JTCalendarDayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    self.clipsToBounds = YES;
    
    _circleRatio = .95;
    _dotRatio = 1. / 12.;
    _backDotRatio = 1. / 15.;
    self.backgroundColor = [UIColor clearColor];
    UIColor *black = [UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1];
    
    {
        _backCircleView = [UIView new];
        [self addSubview:_backCircleView];
        
        _backCircleView.backgroundColor = [UIColor clearColor];
        _backCircleView.layer.borderWidth = 0.0;
        _backCircleView.layer.borderColor = [UIColor whiteColor].CGColor;
        _backCircleView.hidden = YES;
        
        _backCircleView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _backCircleView.layer.shouldRasterize = YES;
    }
    {
        _backTopTextLabel = [UILabel new];
        [_backCircleView addSubview:_backTopTextLabel];
        
        _backTopTextLabel.textColor = black;
        _backTopTextLabel.textAlignment = NSTextAlignmentCenter;
        _backTopTextLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize] - 1];
    }
    {
        _backBottomTextLabel = [UILabel new];
        [_backCircleView addSubview:_backBottomTextLabel];
        
        _backBottomTextLabel.textColor = black;
        _backBottomTextLabel.textAlignment = NSTextAlignmentCenter;
        _backBottomTextLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize] + 1];
    }
    {
        _backSeperateLine = [UIView new];
        [_backCircleView addSubview:_backSeperateLine];
        _backSeperateLine.backgroundColor = black;
    }
    {
        _backDotView = [UIView new];
        [_backCircleView addSubview:_backDotView];
        
        _backDotView.backgroundColor = [UIColor whiteColor];
        _backDotView.hidden = YES;
        
        _backDotView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _backDotView.layer.shouldRasterize = YES;
    }
    
    {
        _circleView = [UIView new];
        [self addSubview:_circleView];
        
        _circleView.backgroundColor = [UIColor clearColor];
        _circleView.layer.borderWidth = 0.0;
        _circleView.layer.borderColor = [UIColor whiteColor].CGColor;
        _circleView.hidden = NO;

        _circleView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _circleView.layer.shouldRasterize = YES;
    }
    {
        _dotView = [UIView new];
        [_circleView addSubview:_dotView];
        
        _dotView.backgroundColor = [UIColor whiteColor];
        _dotView.hidden = YES;

        _dotView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _dotView.layer.shouldRasterize = YES;
    }
    {
        _textLabel = [UILabel new];
        [_circleView addSubview:_textLabel];
        
        _textLabel.textColor = black;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    
    {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouch)];
        
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
            
    CGFloat sizeCircle = MIN(self.frame.size.width, self.frame.size.height);
    CGFloat sizeDot = sizeCircle;
    CGFloat backSizeDot = sizeCircle;
    
    sizeCircle = sizeCircle * _circleRatio;
    sizeDot = sizeDot * _dotRatio;
    backSizeDot = backSizeDot * _backDotRatio;
    
    sizeCircle = roundf(sizeCircle);
    sizeDot = roundf(sizeDot);
    
    _circleView.frame = CGRectMake(0, 0, sizeCircle, sizeCircle);
    _circleView.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
    _circleView.layer.cornerRadius = sizeCircle/2;
    _dotView.frame = CGRectMake(0, 0, sizeDot, sizeDot);
    _dotView.center = CGPointMake(self.frame.size.width / 2. - 1, self.frame.size.height - sizeDot * 1.5 - 4);
    _dotView.layer.cornerRadius = sizeDot / 2.;
    _textLabel.frame = _circleView.bounds;
    
    _backCircleView.frame = CGRectMake(0, 0, sizeCircle, sizeCircle);
    _backCircleView.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
    _backCircleView.layer.cornerRadius = 1;
    _backDotView.frame = CGRectMake(0, 0, backSizeDot, backSizeDot);
    _backDotView.center = CGPointMake(self.frame.size.width / 2. - 1, self.frame.size.height - backSizeDot * 1.5 - 2);
    _backDotView.layer.cornerRadius = backSizeDot / 2.;
    _backTopTextLabel.frame = CGRectMake(0, 0, _backCircleView.bounds.size.width, _backCircleView.bounds.size.height / 3);
    _backBottomTextLabel.frame = CGRectMake(0, _backCircleView.bounds.size.height / 3, _backCircleView.bounds.size.width, _backCircleView.bounds.size.height / 3 * 2);
    
    CGFloat seperatorPadding = 8.0;
    _backSeperateLine.frame = CGRectMake(seperatorPadding, _backCircleView.bounds.size.height / 3 + 2, _backCircleView.bounds.size.width - seperatorPadding * 2, 0.5);
}

- (void)setDate:(NSDate *)date
{
    NSAssert(date != nil, @"date cannot be nil");
    NSAssert(_manager != nil, @"manager cannot be nil");
    
    self->_date = date;
    [self reload];
}

- (void)reload
{    
    static NSDateFormatter *dateFormatter = nil;
    if(!dateFormatter){
        dateFormatter = [_manager.dateHelper createDateFormatter];
    }
    [dateFormatter setDateFormat:self.dayFormat];

    _textLabel.text = [ dateFormatter stringFromDate:_date];
    _backTopTextLabel.text = [ dateFormatter stringFromDate:_date];
    [_manager.delegateManager prepareDayView:self];
}

- (void)didTouch
{
    [_manager.delegateManager didTouchDayView:self];
}

- (NSString *)dayFormat
{
    return self.manager.settings.zeroPaddedDayFormat ? @"dd" : @"d";
}

@end
