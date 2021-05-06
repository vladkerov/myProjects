//
//  ContentView.swift
//  testNetworkingServiceSwiftUI
//
//  Created by Vlad Kerov on 03.05.2021.
//

import SwiftUI
import OAuth2
import Alamofire
//creating instance of Network class for using it's data for authorization requests
let oauthNetwork = Network()

struct ContentView: View {
    
    @State var isActive: Bool = true
    
    var body: some View {
        
        NavigationView {
            if self.isActive {
                //                    on pressed button OAuth2 authorization happens
                Button("PRESS TO AUTHORIZE!", action: { AF.request("https://api.dribbble.com/v2/user/shots",encoding: JSONEncoding.default, interceptor: OAuth2RetryHandler(oauth2: oauthNetwork.oauth2), requestModifier: { $0.timeoutInterval = 5 } ).validate().responseJSON() { response in
                    //                        JSON result is recieved
                    //                                                debugPrint(response)
                    let result = response.result
                    switch result {
                    case .success(let value):
                        //                            in success case trying to cast JSON data to array of dictionaries
                        if let responseArrayOfDictionaries = value as? [[String:Any]]{
                            //                                passing array to function for data parsing
                            dataResponseHandler(responseArrayOfDictionaries: responseArrayOfDictionaries)
                        } else{
                            print("error occured during unwrapping response data!")
                        }
                    case .failure(let error):
                        print(error)
                    }//switch
                    self.isActive.toggle()
                }//response
                }//AF request
                ).font(.title)//button
                .padding()
            }// if isActive
            else {
                //                    when authorization is passed and data are parsed- next view appears
                ListView().padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

