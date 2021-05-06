//
//  DataModel.swift
//  testNetworkingServiceSwiftUI
//
//  Created by Vlad Kerov on 04.05.2021.
//

import Foundation
//model for user's shots
class DataModel {
    let id: String?
    let title: String?
    let description: String?
    let published_at: String?
    let updated_at: String?
    let width: String?
    let height: String?
    let image_url: String?
    init(_ id: String?, title: String?, description: String?, published_at: String?, updated_at: String?, width: String?, height: String?, image_url: String?) {
        self.id = id
        self.title = title
        self.description = description?.removeHTMLTag()
        self.published_at = published_at
        self.updated_at = updated_at
        self.width = width
        self.height = height
        self.image_url = image_url
    }
}
//array of all user shots
var shots = [DataModel]()

//extension for removing HTML tags
extension String {
    func removeHTMLTag() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}
