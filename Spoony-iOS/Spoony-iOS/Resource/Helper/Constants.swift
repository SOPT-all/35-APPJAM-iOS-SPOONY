//
//  Constants.swift
//  SpoonMe
//
//  Created by 이지훈 on 1/2/25.
//

import Foundation

struct Constants {
    
    struct API {
            static var baseURL: String {
                guard let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
                    fatalError("BASE_URL not found in Info.plist")
                }
                return url
            }
        }
    
    struct NaverMap {
        static var clientId: String {
            guard let clientId = Bundle.main.object(forInfoDictionaryKey: "NMFClientId") as? String else {
                fatalError("NMFClientId not found in Info.plist")
            }
            return clientId
        }
        
        static var clientSecret: String {
            guard let path = Bundle.main.path(forResource: "PrivacyInfo", ofType: "plist"),
                  let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
                  let clientSecret = dict["ClientSecret"] as? String else {
                fatalError("ClientSecret not found in PrivacyInfo.plist")
            }
            return clientSecret
        }
    }
}
