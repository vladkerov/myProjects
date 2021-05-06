//
//  Network.swift
//  testNetworkingServiceSwiftUI
//
//  Created by Vlad Kerov on 03.05.2021.
//

import Foundation
import OAuth2
//network data for authorization at server and using it's API
class Network {
    
    let oauth2 = OAuth2CodeGrant(settings: [
        "client_id": "10f65c116e40aefd6b175a5b81b7b4cf34a7aba58e26924ff1467805e609590d",
        "client_secret": "5ca3b24e549e02c4ecef0dad641290ebfdff6a43730b09f9ddd7261772b81ee3",
        "authorize_uri": "https://dribbble.com/oauth/authorize",
        "token_uri": "https://dribbble.com/oauth/token",
        "redirect_uris": ["testapioauth://oauth/callback"],
        "scope": "public upload",
        "secret_in_body": true,
        "keychain": false,
    ] as OAuth2JSON)
    
}
