//
//  ViewController.swift
//  Light
//
//  Created by Sander de Vries on 01/11/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var lightOn = true
    
    // Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    /// Switches light after press
    @IBAction func buttonPressed(_ sender: Any) {
        
        // change lightOn status and change background
        lightOn = !lightOn
        updateUI()
    }
    
    func updateUI() {
        view.backgroundColor = lightOn ? .white : .black
        toggleFlash()
    }
    
    /// Use flash if device is capable
    func toggleFlash() {
        
        // initiate media device to adjust flash
        guard let flashDevice = AVCaptureDevice.default(for: .video) else {
            print("AVCaptureDevice object cannot be initialized")
            return
        }
        
        if flashDevice.hasTorch && flashDevice.isTorchAvailable {
            do {
                // get lock before setting properties
                try flashDevice.lockForConfiguration()
                
                if lightOn {
                    flashDevice.torchMode = .on
                } else {
                    flashDevice.torchMode = .off
                }
                
                // release lock
                flashDevice.unlockForConfiguration()
                
                // lock failed
            } catch {
                print("Flash cannot be used")
            }
            
            // device's torch is not available
        } else {
            print("Flash is not available")
        }
    }
}
