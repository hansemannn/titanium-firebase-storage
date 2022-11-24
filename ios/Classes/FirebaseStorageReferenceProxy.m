/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import <TitaniumKit/TitaniumKit.h>
#import <FirebaseStorage/FirebaseStorage-Swift.h>

#import "FirebaseStorageReferenceProxy.h"
#import "FirebaseUtilities.h"

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

- (FirebaseStorageReferenceProxy *)child:(id)path
{
  ENSURE_SINGLE_ARG(path, NSString);

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

  FIRStorageUploadTask *task = nil;

  typedef void (^UploadCompletionHandler)(FIRStorageMetadata *metadata, NSError *error);

  UploadCompletionHandler uploadCompletion = ^(FIRStorageMetadata *metadata, NSError *error) {
    if (error != nil) {
      [callback call:@[ @{
        @"success" : @(NO),
        @"error" : error.localizedDescription
      } ] thisObject:self];
      return;
    }

    [callback call:@[ @{
      @"success" : @(YES),
      @"metadata" : [FirebaseUtilities dictionaryFromMetadata:metadata]
    } ] thisObject:self];
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

- (void)downloadURL:(id)callback
{
  ENSURE_SINGLE_ARG(callback, KrollCallback);

  [_reference downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
    [callback call:@[@{ @"url": URL.absoluteString }] thisObject:self];
  }];
}

- (void)download:(id)arguments
{
  ENSURE_SINGLE_ARG(arguments, NSDictionary);

  KrollCallback *callback = [arguments objectForKey:@"callback"];
  NSNumber *maxSize = [arguments objectForKey:@"maxSize"];

  [_reference dataWithMaxSize:maxSize.intValue
                   completion:^(NSData *data, NSError *error) {
                     if (error != nil) {
                       [callback call:@[ @{ @"success" : @(NO),
                         @"error" : error.localizedDescription } ]
                           thisObject:self];
                       return;
                     }

                     [callback call:@[ @{
                       @"success" : @(YES),
                       @"data" : [[TiBlob alloc] initWithData:data mimetype:@"text/plain"]
                     } ] thisObject:self];
                   }];
}

- (void)delete:(id)arguments
{
  ENSURE_SINGLE_ARG(arguments, NSDictionary);

  KrollCallback *callback = [arguments objectForKey:@"callback"];

  [_reference deleteWithCompletion:^(NSError *error) {
    [callback call:@[ @{ @"success" : @(error == nil),
      @"error" : NULL_IF_NIL([error localizedDescription]) } ]
        thisObject:self];
  }];
}

- (void)getMetadata:(id)callback
{
  ENSURE_SINGLE_ARG(callback, KrollCallback);

  [_reference metadataWithCompletion:^(FIRStorageMetadata *metadata, NSError *error) {
    if (error != nil) {
      [callback call:@[ @{ @"success" : @(NO),
        @"error" : error.localizedDescription } ]
          thisObject:self];
      return;
    }

    [callback call:@[ @{ @"success" : @(YES),
      @"metadata" : [FirebaseUtilities dictionaryFromMetadata:metadata] } ]
        thisObject:self];

  }];
}

@end
