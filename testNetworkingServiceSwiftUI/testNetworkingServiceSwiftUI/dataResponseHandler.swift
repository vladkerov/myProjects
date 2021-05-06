//
//  dataResponseHandler.swift
//  testNetworkingServiceSwiftUI
//
//  Created by Vlad Kerov on 05.05.2021.
//

import Foundation
//function for parsing data and adding it to model
func dataResponseHandler(responseArrayOfDictionaries: [[String:Any]]){
    for index in (0..<responseArrayOfDictionaries.count) {
        var id0: String = ""
        var title0: String = ""
        var description0: String = ""
        var published_at0: String = ""
        var updated_at0: String = ""
        var width0: String = ""
        var height0: String = ""
        var image_url0: String = ""

        if let image = responseArrayOfDictionaries[index]["images"] as? [String: String?] {
            if let imageURL = image["normal"] {
                image_url0 = unwrappingDoubleOptional(value: imageURL)
            }
        }
        id0 = unwrappingDoubleOptional(value: responseArrayOfDictionaries[index]["id"])
        title0 = unwrappingDoubleOptional(value: responseArrayOfDictionaries[index]["title"])
        published_at0 = unwrappingDoubleOptional(value: responseArrayOfDictionaries[index]["published_at"])
        description0 = unwrappingDoubleOptional(value: responseArrayOfDictionaries[index]["description"])
        updated_at0 = unwrappingDoubleOptional(value: responseArrayOfDictionaries[index]["updated_at"])
        width0 = unwrappingDoubleOptional(value: responseArrayOfDictionaries[index]["width"])
        height0 = unwrappingDoubleOptional(value: responseArrayOfDictionaries[index]["height"])
   
        let newShot = DataModel(id0, title: title0, description: description0, published_at: published_at0, updated_at: updated_at0, width: width0, height: height0, image_url: image_url0)
        shots.append(newShot)
    }
}
