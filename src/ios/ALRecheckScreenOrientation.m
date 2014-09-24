#import "ALRecheckScreenOrientation.h"
#import <Cordova/CDV.h>

@implementation ALRecheckScreenOrientation

- (void)recheckScreenOrientation:(CDVInvokedUrlCommand*)command
{
    // HACK: Force rotate by changing the view hierarchy. Present modal view then dismiss it immediately.
    [self.viewController presentViewController:[UIViewController new] animated:NO completion:^{
        // delaying dismissal is necessary on iOS 8, crashes otherwise
        dispatch_after(0, dispatch_get_main_queue(), ^{
            [self.viewController dismissViewControllerAnimated:NO completion:nil];
        });
    }];

    // Assume everything went ok
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end
