//
//  PKTextFieldTableViewCell.h
//  PKToolbox
//
//  Created by Pavel Kunc on 17/05/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz
//


@protocol PKTextFieldTableViewCellDelegate <NSObject>
@optional
- (void)textFieldDidBeginEditing:(UITextField *)textField forCell:(UITableViewCell *)aCell;
- (void)textFieldDidEndEditing:(UITextField *)textField forCell:(UITableViewCell *)aCell;
@end


@interface PKTextFieldTableViewCell : UITableViewCell <UITextFieldDelegate> {
@private
    id <PKTextFieldTableViewCellDelegate>  delegate_;
    UITextField                           *textField_;
    UILabel                               *textLabel_;
}

@property (nonatomic, assign, readwrite) id <PKTextFieldTableViewCellDelegate>  delegate;
@property (nonatomic, retain, readwrite) UITextField                           *textField;
@property (nonatomic, retain, readwrite) UILabel                               *textLabel;

- (UIToolbar *)keyboardToolbar;

@end

