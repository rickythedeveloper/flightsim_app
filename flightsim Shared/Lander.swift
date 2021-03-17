//
//  object.swift
//  flightsim
//
//  Created by Rintaro Kawagishi on 16/03/2021.
//


import SceneKit

class FlyingObject {
    
    static func object(objectSceneName: String, objectName: String) {
        let objScene = SCNScene(named: objectSceneName)!
        let object = objScene.rootNode.childNode(withName: objectName, recursively: true)!
        object.physicsBody?.allowsResting = false // do not stop object simulation when it becomes stationary
        object.physicsBody?.damping = 0.0 // air resistance
//        object.worldPosition = SCNVector3(0, 100, 0)
    }
}
