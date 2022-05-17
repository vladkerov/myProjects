//
//  ContentView.swift
//  MapToMySQLtest
//
//  Created by Vlad Kerov on 16.05.2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(.systemBlue).ignoresSafeArea()
                VStack{
                    Spacer()
                    Image(systemName: "paperplane.circle.fill").resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.bottom, 32)
                    
                    Text("Would you like to explore places nearby?")
                        .font(.system(size: 28, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("Start sharing your location with us")
                        .multilineTextAlignment(.center)
                        .frame(width: 140)
                        .padding()
                    
                    Spacer()
                    
                    VStack{
                        NavigationLink(destination: MapView(), label: {
                            Text("Show your current location")
                                .padding()
                                .font(.headline)
                                .foregroundColor(Color(.systemBlue))
                            
                                .frame(width: UIScreen.main.bounds.width)
                                .padding(.horizontal, -32)
                                .background(Color.white)
                                .clipShape(Capsule())
                            .padding()})
                        
                        
                        NavigationLink(destination: LastPositionView(), label: {
                            Text("Show your last location from MySQL")
                                .padding()
                                .font(.headline)
                                .foregroundColor(Color(.systemBlue))
                            
                                .frame(width: UIScreen.main.bounds.width)
                                .padding(.horizontal, -32)
                                .background(Color.white)
                                .clipShape(Capsule())
                            .padding()})
                        Button {
                            print("Dismiss")
                        } label:{
                            Text("Maybe later")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding(.bottom, 32)
                }
                .foregroundColor(.white)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
