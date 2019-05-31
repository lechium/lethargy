#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaRemote/MediaRemote.h>

%hook PBWindowManager

- (void)presentDialogViewController:(id)arg1 options:(id)arg2 { 
    
         %log;  
        MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef info) {
        //NSLog(@"We got the information: %@", info);
        NSString *mediaType = [info valueForKey:@"kMRMediaRemoteNowPlayingInfoMediaType"];

        if (info != nil){

            if ([mediaType containsString:@"Music"]){
                %orig;
            } else {
                 NSLog(@"video playing! fuck yo couch Apple!!");
            }
            
        } else {
            %orig;
        }

    });
}

%end

