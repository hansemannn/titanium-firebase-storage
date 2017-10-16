# Firebase Storage Titanium Module
Use the native  Firebase SDK in Axway Titanium. This repository is part of the [Titanium Firebase](https://github.com/hansemannn/titanium-firebase) project.

## Requirements
- [x] Titanium SDK 6.2.0 or later

## API's

### `FirebaseStorage`

#### Methods

##### `referenceForURL(url)`
  - `url` (String)
  
##### `referenceForPath(path)`
  - `path` (String)
  
#### Properties

##### `storageURL` (String, set)

##### `maxUploadRetryTime` (Number)

##### `maxDownloadRetryTime` (Number)

##### `maxOperationRetryTime` (Number)

### `FirebaseStorage.Reference`

#### Methods

##### `upload(parameters)`
  - `parameters` (Dictionary)
    - `data` (Ti.Blob | String)
    - `callback` (Function)

##### `download(parameters)`
  - `parameters` (Dictionary)
    - `maxSize` (Number)
    - `callback` (Function)

##### `delete(parameters)`
  - `parameters` (Dictionary)
    - `callback` (Function)

##### `getMetadata(callback)`
  - `callback` (Function)
  
## Example
```js
// Require the Firebase Storage module
var FirebaseStorage = require('firebase.storage');

// Configure FirebaseStorage
FirebaseStorage.configure();

FirebaseStorage.upload({
  data: myBlob,
  callback: function(e) {
    if (!e.success) {
      Ti.API.error('Error: ' + e.error);
    }
    
    Ti.API.info('Upload completed! Download-URL: ' + e.downloadURL);
  }
});
```

## Build
```js
cd iphone
appc ti build -p ios --build-only
```

## Legal

This module is Copyright (c) 2017-Present by Appcelerator, Inc. All Rights Reserved. 
Usage of this module is subject to the Terms of Service agreement with Appcelerator, Inc.  
