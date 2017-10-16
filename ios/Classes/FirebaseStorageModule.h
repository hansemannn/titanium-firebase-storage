/**
 * titanium-firebase-storage
 *
 * Created by Hans Knoechel
 * Copyright (c) 2017 Your Company. All rights reserved.
 */

#import "FirebaseStorageReferenceProxy.h"
#import "TiModule.h"

@interface FirebaseStorageModule : TiModule {
  NSURL *_storageURL;
}

#pragma mark Public API's

- (FirebaseStorageReferenceProxy *)referenceForURL:(NSString *)url;

- (FirebaseStorageReferenceProxy *)referenceForPath:(NSString *)path;

- (void)setStorageURL:(NSString *)storageURL;

- (void)setMaxUploadRetryTime:(NSNumber *)maxUploadRetryTime;

- (void)setMaxDownloadRetryTime:(NSNumber *)maxDownloadRetryTime;

- (void)setMaxOperationRetryTime:(NSNumber *)maxOperationRetryTime;

@end
