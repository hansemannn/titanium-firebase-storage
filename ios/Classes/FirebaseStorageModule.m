/**
 * titanium-firebase-storage
 *
 * Created by Hans Knoechel
 * Copyright (c) 2017 Your Company. All rights reserved.
 */

#import "FirebaseStorageModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

#import <FirebaseStorage/FirebaseStorage.h>

@implementation FirebaseStorageModule

#pragma mark Internal

- (id)moduleGUID
{
  return @"b31cb727-bdea-440a-ba55-9083e4cd7c23";
}

- (NSString *)moduleId
{
  return @"firebase.storage";
}

#pragma mark Lifecycle

- (void)startup
{
  [super startup];
  NSLog(@"[DEBUG] %@ loaded", self);
}

#pragma mark Internal

- (FIRStorage *)storage
{
  if (_storageURL == nil) {
    return [FIRStorage storage];
  }

  // TODO: Expose FIRApp usage as well

  return [FIRStorage storageWithURL:_storageURL.absoluteString];
}

#pragma Public APIs

- (FirebaseStorageReferenceProxy *)referenceForURL:(id)url
{
  ENSURE_SINGLE_ARG(url, NSString);

  return [[FirebaseStorageReferenceProxy alloc] _initWithPageContext:self.pageContext
                                                        andReference:[[FIRStorage storage] referenceForURL:url]];
}

- (FirebaseStorageReferenceProxy *)referenceForPath:(id)path
{
  ENSURE_SINGLE_ARG(path, NSString);

  return [[FirebaseStorageReferenceProxy alloc] _initWithPageContext:self.pageContext
                                                        andReference:[[FIRStorage storage] referenceWithPath:path]];
}

- (void)setStorageURL:(NSString *)storageURL
{
  _storageURL = [NSURL URLWithString:storageURL];
  [self replaceValue:storageURL forKey:@"storageURL" notification:NO];
}

- (void)setMaxUploadRetryTime:(NSNumber *)maxUploadRetryTime
{
  [[FIRStorage storage] setMaxUploadRetryTime:maxUploadRetryTime.doubleValue];
}

- (void)setMaxDownloadRetryTime:(NSNumber *)maxDownloadRetryTime
{
  [[FIRStorage storage] setMaxDownloadRetryTime:maxDownloadRetryTime.doubleValue];
}

- (void)setMaxOperationRetryTime:(NSNumber *)maxOperationRetryTime
{
  [[FIRStorage storage] setMaxOperationRetryTime:maxOperationRetryTime.doubleValue];
}

@end
