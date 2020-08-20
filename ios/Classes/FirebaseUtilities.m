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
    @"cacheControl" : NULL_IF_NIL(metadata.cacheControl),
    @"contentDisposition" : NULL_IF_NIL(metadata.contentDisposition),
    @"contentEncoding" : NULL_IF_NIL(metadata.contentEncoding),
    @"contentLanguage" : NULL_IF_NIL(metadata.contentLanguage),
    @"contentType" : NULL_IF_NIL(metadata.contentType),
    @"customMetadata" : NULL_IF_NIL(metadata.customMetadata),
    @"name" : NULL_IF_NIL(metadata.name),
    @"path" : NULL_IF_NIL(metadata.path),
    @"fullPath": NULL_IF_NIL(metadata.storageReference.fullPath),
    @"size" : @(metadata.size),
    @"timeCreated" : NULL_IF_NIL(metadata.timeCreated),
    @"updated" : NULL_IF_NIL(metadata.updated),
    @"isFile" : @(metadata.isFile),
    @"isFolder" : @(metadata.isFolder)
  };
}

@end
