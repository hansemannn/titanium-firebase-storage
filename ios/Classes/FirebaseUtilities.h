//
//  FirebaseUtilities.h
//  titanium-firebase-storage
//
//  Created by Hans Knöchel on 16.10.17.
//

#import <Foundation/Foundation.h>

@class FIRStorageMetadata;

@interface FirebaseUtilities : NSObject

+ (NSDictionary *)dictionaryFromMetadata:(FIRStorageMetadata *)metadata;

@end
