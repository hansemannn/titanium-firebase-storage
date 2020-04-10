//
//  FirebaseUtilities.m
//  titanium-firebase-storage
//
//  Created by Hans Knöchel on 16.10.17.
//

#import <FirebaseStorage/FirebaseStorage.h>

#import "FirebaseUtilities.h"
#import "TiBase.h"

@implementation FirebaseUtilities

+ (NSDictionary *)dictionaryFromMetadata:(FIRStorageMetadata *)metadata
{
  return @{
    @"bucket" : metadata.bucket,
    @"cacheControl" : metadata.cacheControl,
    @"contentDisposition" : metadata.contentDisposition,
    @"contentEncoding" : metadata.contentEncoding,
    @"contentLanguage" : metadata.contentLanguage,
    @"contentType" : metadata.contentType,
    @"customMetadata" : metadata.customMetadata,
    @"name" : metadata.name,
    @"path" : metadata.path,
    @"size" : @(metadata.size),
    @"timeCreated" : metadata.timeCreated,
    @"updated" : metadata.updated,
    @"isFile" : @(metadata.isFile),
    @"isFolder" : @(metadata.isFolder)
  };
}

@end
