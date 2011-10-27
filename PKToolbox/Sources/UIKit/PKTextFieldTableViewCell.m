//
//  PKTextFieldTableViewCell.m
//  PKToolbox
//
//  Created by Pavel Kunc on 17/05/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz
//

#import "PKTextFieldTableViewCell.h"


@implementation PKTextFieldTableViewCell

@synthesize delegate = delegate_;
@synthesize textField = textField_;
@synthesize textLabel = textLabel_;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellPadding = 10.0;
        float labelWidth = 120;

        textField_ = [[UITextField alloc] initWithFrame:CGRectMake(cellPadding + labelWidth,
                                                                   cellPadding,
                                                                   self.contentView.bounds.size.width - cellPadding - labelWidth,
                                                                   self.contentView.bounds.size.height)];
        textField_.delegate = self;
        textField_.returnKeyType = UIReturnKeyDone;
        textField_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;


        textLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(cellPadding,
                                                               0.0,
                                                               labelWidth,
                                                               self.contentView.bounds.size.height)];
        textLabel_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        textLabel_.font = [UIFont boldSystemFontOfSize:17];

        [self.contentView addSubview:textField_];
        [self.contentView addSubview:textLabel_];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    self.delegate = nil;
    [textField_ release];
    [textLabel_ release];
    [super dealloc];
}


#pragma mark - Lifecycle

- (void)layoutSubviews {
    [super layoutSubviews];

    switch (self.textField.keyboardType) {
        case UIKeyboardTypePhonePad:
        case UIKeyboardTypeNumberPad:
            self.textField.inputAccessoryView = [self keyboardToolbar];
            break;
        default:
            self.textField.inputAccessoryView = nil;
    }
}


#pragma mark - Keyboard toolbar

- (UIToolbar *)keyboardToolbar {
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    keyboardToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    keyboardToolbar.barStyle = UIBarStyleBlack;
    keyboardToolbar.translucent = NO;

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(textFieldShouldReturn:)];
    UIBarButtonItem *spacerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
    [keyboardToolbar setItems:[NSArray arrayWithObjects:spacerButton, doneButton, nil]
                     animated:NO];
    [doneButton release];
    [spacerButton release];

    return [keyboardToolbar autorelease];
}


#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:forCell:)]) {
        [self.delegate textFieldDidBeginEditing:textField forCell:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:forCell:)]) {
        [self.delegate textFieldDidEndEditing:textField forCell:self];
    }
}

@end

