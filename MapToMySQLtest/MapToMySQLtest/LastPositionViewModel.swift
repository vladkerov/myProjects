//
//  LastPositionViewModel.swift
//  MapToMySQLtest
//
//  Created by Vlad Kerov on 17.05.2022.
//

import Foundation
import Alamofire
import MapKit

class LastPositionViewModel: NSObject, ObservableObject {
    
    static let shared = LastPositionViewModel()
    
    @Published var lastPositionRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(
        latitude: 50.00,
        longitude: 50.00
    ), span: MKCoordinateSpan(
        latitudeDelta: 100,
        longitudeDelta: 100
    ))
    @Published var lastPosition: CLLocationCoordinate2D = CLLocationCoordinate2D(
        latitude: 50.00,
        longitude: 50.00
    )
    
    override init() {
        super.init()
    }
    
    
    //SELECT LAST COORDINATE
    func AlamofireServiceSelectCoordinate(endPoint: String, sqlRequestSelect: String) {
        let parameters: Parameters = ["sqlRequest": sqlRequestSelect]
        
        AF.request(endPoint, method: .post, parameters: parameters).responseDecodable(of: [Response].self) {response in
            
            switch response.result {
                
            case .success(let successResponse):
                
                print("response is successfull..")
                debugPrint(successResponse)
                
                let longitude = successResponse[0].longitude
                let latitude = successResponse[0].latitude
                let cllongitude = CLLocationDegrees(longitude)
                let cllatitude = CLLocationDegrees(latitude)
                let clcoordinate = CLLocationCoordinate2D(latitude: cllatitude!, longitude: cllongitude!)
                
                debugPrint(clcoordinate)
                
                let region = MKCoordinateRegion(center: clcoordinate, span: MKCoordinateSpan(
                    latitudeDelta: 1,
                    longitudeDelta: 1
                ))
                self.lastPositionRegion = region
                self.lastPosition = clcoordinate
                
                
            case .failure(let error):
                print("response is failed...")
                print(error)
            }
        }
        
    }
    
    
}

