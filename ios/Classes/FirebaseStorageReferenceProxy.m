/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "FirebaseStorageReferenceProxy.h"
#import "TiBlob.h"

@implementation FirebaseStorageReferenceProxy

- (id)_initWithPageContext:(id<TiEvaluator>)context
              andReference:(FIRStorageReference *)reference
{
  if (self = [super _initWithPageContext:context]) {
    _reference = reference;
  }
  
  return self;
}

#pragma mark Public APIs

- (FirebaseStorageReferenceProxy *)parent
{
  return [[FirebaseStorageReferenceProxy alloc] _initWithPageContext:self.pageContext
                                                        andReference:_reference.parent];
}

- (FirebaseStorageReferenceProxy *)child:(NSString *)path
{
  return [[FirebaseStorageReferenceProxy alloc] _initWithPageContext:self.pageContext
                                                        andReference:[_reference child:path]];
}

- (FirebaseStorageReferenceProxy *)root
{
  return [[FirebaseStorageReferenceProxy alloc] _initWithPageContext:self.pageContext
                                                        andReference:_reference.root];
}

- (NSString *)bucket
{
  return _reference.bucket;
}

- (NSString *)fullPath
{
  return _reference.fullPath;
}

- (NSString *)name
{
  return _reference.name;
}

- (void)upload:(id)arguments
{
  ENSURE_SINGLE_ARG(arguments, NSDictionary);
  
  TiBlob *data = [arguments objectForKey:@"data"];
  
  FIRStorageUploadTask *task = [_reference putData:data.data];
  [task enqueue];
}

- (void)download:(id)arguments
{
  ENSURE_SINGLE_ARG(arguments, NSDictionary);
  
  [_reference downloadURLWithCompletion:^(NSURL *url, NSError *error) {
    
  }];
}

@end
