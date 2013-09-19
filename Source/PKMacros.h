//
//  PKMacros.h
//  PKToolBox
//
//  Created by Pavel Kunc on 17/07/2013.
//  Copyright (c) 2013 PKToolBox. All rights reserved.
//

#define PK_NIL_IF_NULL(obj) ((obj == [NSNull null]) ? nil : obj)
#define PK_NULL_IF_NIL(obj) ((obj == nil) ? [NSNull null] : obj)

#define PK_BOOL_TO_LOCALIZED_STRING(val) ((val == YES) ? NSLocalizedString(@"Yes", nil) : NSLocalizedString(@"No", nil))

#define PK_IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define PK_IS_IPHONE ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
#define PK_IS_IPHONE_5 ( PK_IS_IPHONE && PK_IS_WIDESCREEN )

