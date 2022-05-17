//
//  LastPositionView.swift
//  MapToMySQLtest
//
//  Created by Vlad Kerov on 16.05.2022.


import SwiftUI
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct LastPositionView: View {
    
    @ObservedObject private var manager = LastPositionViewModel.shared
    
    var body: some View {
        ZStack{
            
            let mapLocations = [
                MapLocation(name: "Last position", coordinate: manager.lastPosition)
            ]
            Map(coordinateRegion: $manager.lastPositionRegion, annotationItems: mapLocations){
                MapPin(coordinate: $0.coordinate)
            }.ignoresSafeArea()
            
            
            Button{
                print("Retrieve last location from MySQL...")
                manager.AlamofireServiceSelectCoordinate(endPoint: endPoint, sqlRequestSelect: sqlRequestSelectLast)
            } label: {
                Text("Retrieve last location from MySQL")
                    .padding()
                    .font(.headline)
                    .foregroundColor(Color(.systemBlue))
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.horizontal, -32)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding()
            }.frame(maxHeight: .infinity, alignment: .bottom)
            
        }
    }
}

struct LastPositionView_Previews: PreviewProvider {
    
    static var previews: some View {
        LastPositionView()
    }
}
