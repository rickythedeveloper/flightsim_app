//
//  GameViewController.swift
//  flightsim macOS
//
//  Created by Rintaro Kawagishi on 13/03/2021.
//

import Cocoa
import SceneKit

class GameViewController: NSViewController {
    
    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameController: GameController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameController = GameController(sceneRenderer: gameView)
        
        // Allow the user to manipulate the camera
//        self.gameView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information
        self.gameView.showsStatistics = true
        
        // Configure the view
        self.gameView.backgroundColor = NSColor.black
        
        // Add a click gesture recognizer
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        var gestureRecognizers = gameView.gestureRecognizers
        gestureRecognizers.insert(clickGesture, at: 0)
        self.gameView.gestureRecognizers = gestureRecognizers
        
        setupSlide()
    }
    
    private func setupSlide() {
        let slider = NSSlider(target: self, action: #selector(engineSliderChanged))
        let margin: CGFloat = 30
        slider.frame = NSRect(x: margin, y: margin, width: 50, height: self.view.bounds.height - margin*2)
        slider.isVertical = true
        self.view.addSubview(slider)
    }
    
    @objc func engineSliderChanged(sender: NSSlider) {
        gameController.setThrottle(SCNNumber(sender.floatValue))
    }
    
    @objc
    func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
        // Highlight the clicked nodes
        let p = gestureRecognizer.location(in: gameView)
    }
    
}
