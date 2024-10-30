import Foundation
import TrainerVideoSDK
import React 

@objc(BridgeRn)
class BridgeRn: NSObject {
    
// VideoPlayer is now initialized per method call, not globally, since we pass new URLs each time
    override init() {
        super.init()
    }
    
    @objc(launchVideoEditor:secondURL:resolver:rejecter:)
    func launchVideoEditor(_ urlString: String, secondURL: String? = nil, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        // Ensure the first URL is valid
        guard let url = URL(string: urlString) else {
            return reject("invalid_url", "The provided URL is invalid", nil)
        }
        
        // Optional second URL, handle only if provided
        var secondVideoURL: URL? = nil
        if let secondURLString = secondURL, let validSecondURL = URL(string: secondURLString) {
            secondVideoURL = validSecondURL
        }
        
        DispatchQueue.main.async {
            guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
                return reject("no_root_view_controller", "No root view controller found", nil)
            }
            
            // Create and present the VideoPlayer with both URLs (second is optional)
            let videoPlayer = VideoPlayer(videoURL1: url, videoURL2: secondVideoURL)
            rootViewController.present(videoPlayer, animated: true) {
                resolve(nil) // Successfully presented the video player
            }
        }
    }
    
    // Indicates that this module should be initialized on the main queue
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
}
