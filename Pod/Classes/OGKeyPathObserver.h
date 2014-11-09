//
//  OGKeyPathObserver.h
//  Phonic
//
//  Created by Jesper on 14/07/15.
//  Copyright (c) 2014 Orange Groove. All rights reserved.
//

@import Foundation;

/*
 KVO Observer wrapper.
 */

@interface OGKeyPathObserver : NSObject

/**
 Starts observing a path with a callback.
 @param object The object to observe.
 @param keyPath The keypath to observe.
 @param callback The block to call when observation is triggered.
 @note The callback block is retained, so be wary of reference cycles.
 @note Only one combination of object and keypath at a time can be used. Subsequent calls will replace the previous callback.
 */
- (void)observeObject:(id)object keyPath:(NSString *)keyPath callback:(void (^)(NSDictionary* change))callback;

/**
 Removes an observer block.
 @param object The object to stop observing.
 @param keyPath The keypath to stop observing.
 */
- (void)stopObservingObject:(id)object keyPath:(NSString *)keyPath;

/**
 Removes all observer blocks.
 */
- (void)stopObservingAll;

@end
