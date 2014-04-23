cordova-plugin-recheck-screen-orientation
=========================================

This is a cordova / phonegap plugin which allows you to force a cordova app into a permitted orientation by forcing a re-check of `shouldRotateToOrientation`.

### Example:
Assuming we have an app which has a number of 'pages' and `isVideoPage` is `true` when on the video `page` and false on all other pages

```javascript
window.shouldRotateToOrientation = function(orientation) {
  if (isVideoPage) {
    if (orientation === 90 || orientation === -90) { // Landscape
      return true;
    }
  } else {
    if (orientation === 180 || orientation === -180) { // Portrait
      return true;
    }
  }
  return false;
}

// Before entering video page:
cordova.recheckScreenOrientation();

// After leaving video page:
cordova.recheckScreenOrientation();
```

#### Without plugin:
When navigating from a portrait page to a landscape page (landscape to portrait) the page will display in the wrong orientation. Upon turning the device to the correct orientation the screen will turn and stay in the correct orientation.

#### With plugin:
When navigating from a portrait page to a landscape page (landscape to portrait) the page will rotate automatically and the screen will only rotate to supported orientations.

### OS Support

#### iOS

Tested on iOS 6 and 7 on the iPhone. If you test on any other devices please create a pull request to update this readme with your findings or submit an issue.

### Other platforms

Other platforms may be supported in the future.


### Mechanism

#### iOS

There is no official way to get iOS to recheck its supported orientations so we have to resort to a hack.
The plugin adds a modal view to the view hierarchy and then removes it as soon as it as added. This causes iOS to call `shouldRotateOrientation` internally.
This works on all iOS versions tested so far.
