//
//  GameViewController.swift
//  flightsim iOS
//
//  Created by Rintaro Kawagishi on 13/03/2021.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameController: GameController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameController = GameController(sceneRenderer: gameView)
        
        // Allow the user to manipulate the camera
        // self.gameView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information
        self.gameView.showsStatistics = true
        
        // Configure the view
        self.gameView.backgroundColor = UIColor.black
        
        setupSlider()
    }
    
    private func setupSlider() {
        let slider = UISlider(frame: CGRect(x: 50, y: 50, width: 300, height: 50))
        slider.addTarget(self, action: #selector(engineSliderChanged), for: .valueChanged)
        self.view.addSubview(slider)
    }
    
    @objc private func engineSliderChanged(sender: UISlider) {
        let throttle = sender.value
        gameController.setThrottle(throttle)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
