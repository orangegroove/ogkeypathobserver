//
//  OGKeyPathObserver.m
//  Phonic
//
//  Created by Jesper on 14/07/15.
//  Copyright (c) 2014 Orange Groove. All rights reserved.
//

#import "OGKeyPathObserver.h"

@interface OGKeyPathObserver ()

@property (strong, nonatomic) NSMutableArray*	   observedTuples;
@property (strong, nonatomic) NSMutableDictionary* observerCallbacks;

@end
@implementation OGKeyPathObserver

#pragma mark - Lifecycle

- (void)dealloc
{
    [self stopObservingAll];
}

#pragma mark - Public

- (void)observeObject:(id)object keyPath:(NSString *)keyPath callback:(void (^)(NSDictionary *))callback
{
    NSArray* tuple                                   = @[object, [keyPath copy]];
    self.observerCallbacks[[self keyForTuple:tuple]] = [callback copy];
    
    [self.observedTuples addObject:tuple];
    [object addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)stopObservingObject:(id)object keyPath:(NSString *)keyPath
{
    NSArray* tuple = @[object, [keyPath copy]];
    
    [object removeObserver:self forKeyPath:keyPath context:NULL];
    [self.observedTuples removeObject:tuple];
    [self.observerCallbacks removeObjectForKey:[self keyForTuple:tuple]];
}

- (void)stopObservingAll
{
    for (NSArray* tuple in self.observedTuples)
    {
        id object         = tuple.firstObject;
        NSString* keyPath = tuple.lastObject;
        
        [object removeObserver:self forKeyPath:keyPath context:NULL];
    }
    
    self.observedTuples    = nil;
    self.observerCallbacks = nil;
}

#pragma mark - Events

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSArray* tuple                         = @[object, keyPath];
    void (^callback)(NSDictionary* change) = self.observerCallbacks[[self keyForTuple:tuple]];
    
    if (callback)
    {
        callback(change);
    }
}

#pragma mark - Private

- (NSString *)keyForTuple:(NSArray *)tuple
{
    NSParameterAssert(tuple.count == 2);
    NSParameterAssert([tuple.lastObject isKindOfClass:NSString.class]);
    
    return [NSString stringWithFormat:@"%p_%@", tuple.firstObject, tuple.lastObject];
}

#pragma mark - Properties

- (NSMutableArray *)observedTuples
{
    if (_observedTuples) return _observedTuples;
    
    _observedTuples = [NSMutableArray array];
    
    return _observedTuples;
}

- (NSMutableDictionary *)observerCallbacks
{
    if (_observerCallbacks) return _observerCallbacks;
    
    _observerCallbacks = [NSMutableDictionary dictionary];
    
    return _observerCallbacks;
}

@end
