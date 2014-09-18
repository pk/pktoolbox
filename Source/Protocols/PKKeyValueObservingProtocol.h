//
//  PKKeyValueObservingProtocol.h
//  PKToolbox
//
//  Created by Pavel Kunc on 29/11/2012.
//  Copyright (c) 2012 PKToolbox. All rights reserved.
//

@import Foundation;

@protocol PKKeyValueObservingProtocol <NSObject>

@required

- (void)pk_registerKeyValueObservers;
- (void)pk_removeKeyValueObservers;


@optional

- (void)pk_observeValueForKeyPath:(NSString *)keyPath
                         ofObject:(id)object
                           change:(NSDictionary *)change
                          context:(void *)context;

@end

