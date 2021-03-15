//
//  SCNVector3+.swift
//  flightsim iOS
//
//  Created by Rintaro Kawagishi on 13/03/2021.
//

import Foundation
import SceneKit

extension SCNVector3 {
    #if os(macOS)
        typealias SCNNumber = CGFloat
    #else
        typealias SCNNumber = Float
    #endif
    
    static func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
    }
    
    static func * (left: SCNVector3, right: SCNNumber) -> SCNVector3 {
        return SCNVector3(left.x * right, left.y * right, left.z * right)
    }
    
    static func * (left: SCNNumber, right: SCNVector3) -> SCNVector3 {
        return right * left
    }
}
