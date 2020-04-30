//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var timeLeft = 0
    var maxTime = 0
    var timer = Timer()
    var player: AVAudioPlayer!

    @objc func onTimerFires() {
        progressBar.progress = Float(maxTime - timeLeft)/Float(maxTime)
        if timeLeft > 0 {
            timeLeft -= 1
        } else {
            timer.invalidate()
            display.text = "Done!"
            playSound()
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        maxTime = eggTimes[hardness]!
        timeLeft = maxTime
        
        progressBar.progress = 0
        display.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
