//
//  GameController.swift
//  flightsim Shared
//
//  Created by Rintaro Kawagishi on 13/03/2021.
//

import SceneKit
import SpriteKit

#if os(watchOS)
    import WatchKit
#endif

#if os(macOS)
    typealias SCNColor = NSColor
    typealias SCNNumber = CGFloat
#else
    typealias SCNColor = UIColor
    typealias SCNNumber = Float
#endif

class GameController: NSObject {

    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    let lander: SCNNode
    var selfieStick: SCNNode!
    var engineOn: Bool = true
    private var hud: SKScene!
    private var labelNode: SKLabelNode!
    private var throttle: SCNNumber = 0.0 // between 0 and 1
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        scene = SCNScene(named: "Art.scnassets/main.scn")!
        lander = scene.rootNode.childNode(withName: "lander", recursively: true)!
        selfieStick = scene.rootNode.childNode(withName: "selfieStick", recursively: true)!
        
        super.init()
        setupScene()
        setupLander()
        setupHUD()
        sceneRenderer.delegate = self
        sceneRenderer.scene = scene
    }
    
    private func setupScene() {
        scene.physicsWorld.speed = 1.0
        scene.physicsWorld.gravity = SCNVector3(0, -9.81, 0)
    }
    
    private func setupLander() {
        lander.physicsBody?.allowsResting = false // do not stop lander simulation when it becomes stationary
        lander.physicsBody?.damping = 0.0 // air resistance
        lander.worldPosition = SCNVector3(0, 100, 0)
    }
    
    private func setupHUD() {
        let sceneView = sceneRenderer as! SCNView
        hud = SKScene(size: sceneView.bounds.size)
        hud.backgroundColor = SCNColor.blue
        
        labelNode = SKLabelNode()
        labelNode.fontSize = 20
        labelNode.fontName = "AvenirNext-Bold"
        labelNode.fontColor = .black
        labelNode.position.y = 50
        labelNode.position.x = hud.size.width / 2
        hud.addChild(labelNode)
        
        sceneView.overlaySKScene = hud
    }
    
    private func updateHUD() {
        let height = lander.presentation.worldPosition.y
        let vSpeed = lander.physicsBody!.velocity.y
        labelNode.text = "y: \(Int(height)), vy = \(Int(vSpeed))"
    }
    
    func setThrottle(_ value: SCNNumber) {
        throttle = value
    }
    
    func engineForce() -> SCNVector3 {
        let weight = SCNNumber(self.scene.physicsWorld.gravity.y)*SCNNumber(self.lander.physicsBody!.mass)
        let full: SCNNumber = 2
        let yForce = -full * throttle * weight
        return SCNVector3(0, yForce, 0)
    }
}

extension GameController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
        let landerPos = lander.presentation.worldPosition
        selfieStick.worldPosition = landerPos
        
        lander.physicsBody?.applyForce(engineForce(), asImpulse: false)
        updateHUD()
    }
}
