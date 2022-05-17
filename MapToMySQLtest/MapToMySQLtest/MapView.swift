//
//  MapView.swift
//  MapToMySQLtest
//
//  Created by Vlad Kerov on 16.05.2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct AnnotationItem: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @ObservedObject private var mapViewModel = MapViewModel()
    
    var homeLocation : [AnnotationItem] {
        guard let location = mapViewModel.location?.coordinate else {
            return []
        }
        return [.init(name: "Home", coordinate: location)]
    }
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mapViewModel.region, annotationItems: homeLocation) {
                MapPin(coordinate: $0.coordinate)
            }
            .ignoresSafeArea()
            
            Button{
                print("Saving current location...")
                print("\(String(describing: mapViewModel.location?.coordinate))")
                
                if let latitude = mapViewModel.location?.coordinate.latitude,
                   let longitude = mapViewModel.location?.coordinate.longitude{
                    sqlRequestInsert += "('\(longitude)','\(latitude)')"
                    AlamofireServiceInsert(endPoint: endPoint, sqlRequestInsert: sqlRequestInsert)
                } else {
                    print("Location is undefined....")
                }
            } label: {
                Text("Save current location to MySQL")
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

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
