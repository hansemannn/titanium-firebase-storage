//
//  FirebaseUtilities.m
//  titanium-firebase-storage
//
//  Created by Hans Knöchel on 16.10.17.
//

@import FirebaseStorage;

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
    @"size" : NUMLONG(metadata.size),
    @"timeCreated" : metadata.timeCreated,
    @"updated" : metadata.updated,
    @"isFile" : NUMBOOL(metadata.isFile),
    @"isFolder" : NUMBOOL(metadata.isFolder)
  };
}

@end
