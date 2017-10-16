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

@import FirebaseCore;
@import FirebaseStorage;

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
	NSLog(@"[DEBUG] %@ loaded",self);
}

#pragma mark Internal

- (FIRStorage *)storage
{
  if (_storageURL == nil) {
    return [FIRStorage storage];
  }
  
  // TODO: Expose 
  
  return [FIRStorage storageWithURL:_storageURL.absoluteString];
}

#pragma Public APIs

- (void)configure:(id)arguments
{
  if (!arguments || [arguments count] == 0) {
    [FIRApp configure];
    return;
  }
  
  // TODO: Expose options
  __unused NSDictionary *options = [arguments objectAtIndex:0];
  [FIRApp configureWithOptions:FIROptions.defaultOptions];
}

- (FirebaseStorageReferenceProxy *)referenceForURL:(NSString *)url
{
  return [[FirebaseStorageReferenceProxy alloc] _initWithPageContext:self.pageContext
                                                        andReference:[[FIRStorage storage] referenceForURL:url]];
}

- (FirebaseStorageReferenceProxy *)referenceForPath:(NSString *)path
{
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
