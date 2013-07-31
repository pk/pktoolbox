//
//  PKMacros.h
//  PKToolBox
//
//  Created by Pavel Kunc on 17/07/2013.
//  Copyright (c) 2013 PKToolBox. All rights reserved.
//

#define NIL_IF_NULL(obj) ((obj == [NSNull null]) ? nil : obj)
#define NULL_IF_NIL(obj) ((obj == nil) ? [NSNull null] : obj)

#define BOOL_TO_LOCALIZED_STRING(val) ((val == YES) ? NSLocalizedString(@"Yes", nil) : NSLocalizedString(@"No", nil))

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )

