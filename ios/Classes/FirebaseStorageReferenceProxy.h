/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import <TitaniumKit/TitaniumKit.h>

@class FIRStorageReference;

@interface FirebaseStorageReferenceProxy : TiProxy {
  FIRStorageReference *_reference;
}

- (id)_initWithPageContext:(id<TiEvaluator>)context andReference:(FIRStorageReference *)reference;

- (FirebaseStorageReferenceProxy *)parent;

- (FirebaseStorageReferenceProxy *)child:(NSString *)path;

- (FirebaseStorageReferenceProxy *)root;

- (NSString *)bucket;

- (NSString *)fullPath;

- (NSString *)name;

- (void)upload:(id)arguments;

- (void)downloadURL:(id)callback;

- (void)download:(id)arguments;

- (void)delete:(id)arguments;

- (void)getMetadata:(id)callback;

@end
