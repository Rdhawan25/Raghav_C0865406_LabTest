//
//  ViewController.swift
//  Raghav_C0865406_LabTest
//
//  Created by Raghav Dhawan on 05/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var buttonStart: UIButton!
    
    @IBOutlet weak var buttonLap: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var timer = Timer()
    var isStarted = false
    var count:Int = 0
    var lapTimeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @objc private func startTimer() {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = getTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        labelTime.text = timeString
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
    
    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if isStarted {
            isStarted = false
            timer.invalidate()
            buttonStart.setTitle("Start", for: .normal)
        } else {
            isStarted = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
            buttonStart.setTitle("Stop", for: .normal)
        }
        if labelTime.text != "00:00:00"{
            buttonLap.setTitle("Reset", for: .normal)
        } else {
            buttonLap.setTitle("Lap", for: .normal)

        }
        
    }
    
    @IBAction func lapButtonTapped(_ sender: Any) {
        lapTimeArray.append(labelTime.text!)
        tableView.reloadData()
        if buttonLap.titleLabel?.text == "Reset"{
            labelTime.text = "00:00:00"
            lapTimeArray.removeAll()
            tableView.reloadData()
            buttonLap.setTitle("Lap", for: .normal)
            count = 0
            
        }
    }
    
}

extension ViewController : UITableViewDataSource , UITableViewDelegate {
    // MARK: - table view methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapCell")
        cell?.textLabel?.text = lapTimeArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimeArray.count
    }


}

