//
//  testNetworkingServiceSwiftUIApp.swift
//  testNetworkingServiceSwiftUI
//
//  Created by Vlad Kerov on 03.05.2021.
//

import SwiftUI

@main
struct testNetworkingServiceSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
//            on open url by custom url scheme indicated in info->URL types, method handleRedirectURL(url) is called (for code-token exchange)
            ContentView().onOpenURL { (url) in                
//                debugPrint(url)
                if url.host == "oauth" {
                    oauthNetwork.oauth2.handleRedirectURL(url)
                }             
            }
        }
    }
}
