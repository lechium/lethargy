#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaRemote/MediaRemote.h>

/*

Hook PBWindowManager in PineBoard and intercept dialog events, use MediaRemote.framework to check if any media is currently playing
if media is playing back, and its not music (or if MRMediaRemoteGetNowPlayingInfo doesnt return null in general) the method is no-oped
and the alert falls down the memory hole. bye bye!

*/


%hook PBWindowManager

- (void)presentDialogViewController:(id)arg1 options:(id)arg2 { 
    
        //Check to see if anything is now playing
        MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef info) {
        //NSLog(@"We got the information: %@", info);

        //This key may not be available, if its is not, we defer to ignoring the alert.
        NSString *mediaType = [info valueForKey:@"kMRMediaRemoteNowPlayingInfoMediaType"];

        if (info != nil){
            //im not sure if other constants come back different from the Music one in the official music app, im hoping this catches others as well.
            if ([mediaType containsString:@"Music"]){
                %orig; //if its music we still want to show the alert, its not going to interrupt anything (hopefully)
            } else {
                //The media type doesnt exist, or doesnt contain the word music, its safe to say we don't want to see it!
                 NSLog(@"video playing! fuck yo couch Apple!!");
            }
            
        } else { //info is null, nothing is currently playing, call original implementation.
            %orig;
        }

    });
}

%end

