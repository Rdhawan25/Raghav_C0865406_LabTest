//
//  TimerViewController.swift
//  Raghav_C0865406_LabTest
//
//  Created by Raghav Dhawan on 05/11/22.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    
    
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var pickerCount:Int = 0
    var timer2 = Timer()
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startTimePickerButtonTapped(_ sender: Any) {
        playSound()
        pickerCount = Int(datePickerView.countDownDuration)
        let time = secondsToHoursMinutesSeconds(seconds: pickerCount)
        let timeString = getTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timeLabel.text = timeString
//        pickerCount = getTotalSecondsFrom(hours: hour, minutes: minutes, seconds: seconds)
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer2), userInfo: nil, repeats: true)
        datePickerView.isHidden = true
        timeLabel.isHidden = false
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        timer2.invalidate()
        datePickerView.isHidden = false
        timeLabel.isHidden = true
        
    }
    
    @objc private func startTimer2() {
        if pickerCount == 0{
            timer2.invalidate()
            timeLabel.text = "00:00:00"
//            playSound()
            return
        }
        pickerCount = pickerCount - 1
        let time = secondsToHoursMinutesSeconds(seconds: pickerCount)
        let timeString = getTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timeLabel.text = timeString
    }
    
    private func getTotalSecondsFrom(hours: Int, minutes: Int, seconds: Int)-> Int {
        return seconds + (minutes * 60) + (hours * 60 * 60)
    }
    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func getTimeString(hours: Int, minutes: Int, seconds : Int) -> String
    {
        var timeStr = ""
        timeStr += String(format: "%02d", hours)
        timeStr += ":"
        timeStr += String(format: "%02d", minutes)
        timeStr += ":"
        timeStr += String(format: "%02d", seconds)
        return timeStr
    }
    
    func playSound(){
        var audioURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "radar_ios_7", ofType: "mp3")!)
        var player = AVAudioPlayer()
        do{
            player = try AVAudioPlayer(contentsOf: audioURL as URL)
        }
        catch _ as NSError{
            fatalError()
        }
        player.prepareToPlay()
        player.play()
    }
    
    
    
    
    
    
}


