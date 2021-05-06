//
//  unwrappingDoubleOptional.swift
//  testNetworkingServiceSwiftUI
//
//  Created by Vlad Kerov on 06.05.2021.
//

import Foundation
//function that unwraps double optional types
func unwrappingDoubleOptional (value: Any?)->String{
    if let temp = value as? String?, let returnValue = temp {
        return returnValue } else {
            return ""}
}
