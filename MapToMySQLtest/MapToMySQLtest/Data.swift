//
//  Data.swift
//  MapToMySQLtest
//
//  Created by Vlad Kerov on 17.05.2022.
//

import Foundation
import CoreLocation
import MapKit

let endPoint: String = "https://imhht.com/testService.php"
var sqlRequestInsert: String = "INSERT INTO Locations(longitude, latitude) VALUES "
let sqlRequestSelect: String = "SELECT* FROM Locations"
let sqlRequestSelectLast: String = "SELECT * FROM Locations WHERE id = (SELECT MAX(id) FROM Locations)"


