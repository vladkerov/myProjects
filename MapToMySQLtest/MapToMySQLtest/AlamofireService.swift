//
//  AlamofireService.swift
//  MapToMySQLtest
//
//  Created by Vlad Kerov on 17.05.2022.
//

import Foundation
import Alamofire
import CoreLocation
import MapKit

struct Response: Codable{
    
    let id: String
    let name: String
    let address: String
    let longitude: String
    let latitude: String
    
}
//INSERT
func AlamofireServiceInsert(endPoint: String, sqlRequestInsert: String){
    let parameters: Parameters = ["sqlRequest": sqlRequestInsert]
    
    AF.request(endPoint, method: .post, parameters: parameters).validate().response {response in
        
        switch response.result {
            
        case .success(let successResponse):
            print("response is successfull...")
            debugPrint(successResponse ?? "")
        case .failure(let error):
            print("response is failed...")
            print(error)
        }
    }
    
}


//SELECT ALL
func AlamofireServiceSelect(endPoint: String, sqlRequestSelect: String){
    let parameters: Parameters = ["sqlRequest": sqlRequestSelect]
    
    AF.request(endPoint, method: .post, parameters: parameters).responseDecodable(of: [Response].self) {response in
        
        switch response.result {
            
        case .success(let successResponse):
            print("response is successfull...")
            debugPrint(successResponse)
            
        case .failure(let error):
            print("response is failed...")
            print(error)
        }
    }
    
}
