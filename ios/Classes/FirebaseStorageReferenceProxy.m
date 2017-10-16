/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "FirebaseStorageReferenceProxy.h"
#import "TiBlob.h"
#import "TiUtils.h"

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
  
  id data = [arguments objectForKey:@"data"];
  KrollCallback *callback = [arguments objectForKey:@"callback"];
  
  if ([data isKindOfClass:[TiBlob class]]) {
    data = [(TiBlob *)data data];
  } else if ([data isKindOfClass:[NSString class]]) {
    data = [TiUtils toURL:data proxy:self];
  }

  FIRStorageUploadTask *task = nil;
  
  typedef void(^UploadCompletionHandler)(FIRStorageMetadata *metadata, NSError *error);
  
  UploadCompletionHandler uploadCompletion = ^(FIRStorageMetadata *metadata, NSError *error) {
    if (error != nil) {
      [callback call:@[@{ @"success": NUMBOOL(NO), @"error": error.localizedDescription }] thisObject:self];
      return;
    }
    
    [callback call:@[@{ @"downloadURL": metadata.downloadURL.absoluteString }] thisObject:self];
  };
  
  if ([data isKindOfClass:[TiBlob class]]) {
    [_reference putData:[(TiBlob *)data data]
               metadata:nil
             completion:uploadCompletion];
  } else if ([data isKindOfClass:[NSString class]]) {
    [_reference putFile:[TiUtils toURL:data proxy:self]
               metadata:nil
             completion:uploadCompletion];
  } else {
    NSLog(@"[ERROR] Invalid data-type provided, use either Ti.Blob or String!");
  }
  
  [task enqueue];
}

- (void)download:(id)arguments
{
  ENSURE_SINGLE_ARG(arguments, NSDictionary);
  
  KrollCallback *callback = [arguments objectForKey:@"callback"];
  NSNumber *maxSize = [arguments objectForKey:@"maxSize"];

  [_reference dataWithMaxSize:maxSize.intValue
                   completion:^(NSData *data, NSError *error) {
                     if (error != nil) {
                       [callback call:@[@{ @"success": NUMBOOL(NO), @"error": error.localizedDescription }] thisObject:self];
                       return;
                     }
                     
                     [callback call:@[@{ @"data": [[TiBlob alloc] _initWithPageContext:self.pageContext
                                                                               andData:data
                                                                              mimetype:@"text/plain"] }] thisObject:self];
                   }];
}

@end
