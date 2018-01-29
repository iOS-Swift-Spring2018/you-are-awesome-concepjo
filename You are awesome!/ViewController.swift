//
//  ViewController.swift
//  You are awesome!
//
//  Created by Joshua Concepcion on 9/7/17.
//  Copyright © 2017 Joshua Concepcion. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var awesomeImage1: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var soundSwitch: UISwitch!
    
    var awesomePlayer = AVAudioPlayer()
    var index = -1
    var imageNumber = -1
    var soundNumber = -1
    let numberOfImages = 5
    let numberOfSounds = 5
    
    // This code executes when the view controller loads.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - My Own Functions
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        // Can we load in the file soundName?
        
        if let sound = NSDataAsset(name: soundName) {
            // Check if sound.data is a sound file
            
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                
                audioPlayer.play()
            } catch {
                // If sound.data is not a valid audio file.
                print("Error: data in \(soundName) couldn't be played as a sound")
            }
            
        } else {
            // If NSDataAsset didn't work, tell the user / report the error.
            print("ERROR: File\(soundName) didn't load")
        }
        
    }
    
    func nonRepeatingRandom(lastNumber: Int , maxValue: Int) -> Int {
        var newIndex = -1
        repeat {
            newIndex = Int(arc4random_uniform(UInt32(maxValue)))
        } while lastNumber == newIndex
        return newIndex
    }
    
    //MARK: - Actions
    @IBAction func soundSwitchPressed(_ sender: UISwitch) {
        if !soundSwitch.isOn && soundNumber != -1 {
            // stop playing
            awesomePlayer.stop()
        }
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        
        
        let messages = [ "You Are Fantastic!",
                         "You Are Great!",
                         "You Are Amazing!",
                         "When the Genius Bar needs help they call you!",
                         "You Brighten My Day!",
                          " You are da bomb!",
                          " I can't wait to use your app!",
                          "Fabulous? That's you!"]
        
        // Show a message.
        
        index = nonRepeatingRandom(lastNumber: index, maxValue: messages.count)
        messageLabel.text = messages[index]
        
        // Show an image
        awesomeImage1.isHidden = false
        
        imageNumber = nonRepeatingRandom(lastNumber: imageNumber, maxValue: numberOfImages)
        awesomeImage1.image = UIImage(named: "image\(imageNumber)")
        
        
        if soundSwitch.isOn {
        
        // Get a random number to play our sound
        soundNumber = nonRepeatingRandom(lastNumber: soundNumber, maxValue: numberOfSounds)
        // Play a sound.
        let soundName = "sound\(soundNumber)"
        playSound(soundName: soundName, audioPlayer: &awesomePlayer)
        }
        
    }
   
    
}

