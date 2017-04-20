//
//  LiveTrainViewController.swift
//  dc_metro
//
//  Created by Aarya BC on 4/15/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit

class LiveTrainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var trainStations: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    var liveTrain: [NSDictionary] = []
    var countType = [0,0,0,0]
    var groups = 0
    var finalTrain: [NSDictionary] = []
    var stationList: Dictionary<String, String> = [:]
    var stationSelect: Array<String> = []
    var reqStation: String = "B03"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        trainStations.dataSource = self
        trainStations.delegate = self
        
        let trainStation = TrainStationClient()
        
        trainStation.trainStations(success: {(line: Dictionary) ->() in
            self.stationList = line
//            print(self.stationList)
            for (name, _) in self.stationList{
                self.stationSelect.append(name)
            }
            self.stationSelect.sort()
        })
        if stationList[reqStation] != nil{
            self.reqStation = self.stationList[reqStation]!
        }
        trainStation.currentTrains(stationID: self.reqStation, success: {(line: [NSDictionary])->() in
            self.liveTrain = line
//            print(self.liveTrain)
            for item in self.liveTrain{
                let obj = item as NSDictionary
                let grp = Int(obj["Group"] as! String)
                self.countType[grp!-1] += 1
//                print(grp!)
            }
            for item in self.countType{
                if (item > 0){
                    self.groups += 1
                }
            }
            let emptyObj: NSDictionary = NSDictionary()
            var i = 1
            var count = self.groups
            while (count > 0){
                for item in self.liveTrain{
                    let obj = item as NSDictionary
                    let grp = Int(obj["Group"] as! String)
                    if (grp == i){
                        self.finalTrain.append(obj)
                    }
                }
                self.finalTrain.append(emptyObj)
                i += 1
                count -= 1
            }
            print(self.finalTrain.count)
            self.tableView.reloadData()
            self.trainStations.reloadAllComponents()
        })
        // Do any additional setup after loading the view.
    }
    
    func returnTrain(){
        if stationList[reqStation] != nil{
            self.reqStation = self.stationList[reqStation]!
        }
        self.finalTrain = []
        self.groups = 0
        self.countType = [0,0,0,0]
        let trainStation = TrainStationClient()
        trainStation.currentTrains(stationID: self.reqStation, success: {(line: [NSDictionary])->() in
            self.liveTrain = line
            //            print(self.liveTrain)
            for item in self.liveTrain{
                let obj = item as NSDictionary
                let grp = Int(obj["Group"] as! String)
                self.countType[grp!-1] += 1
                //                print(grp!)
            }
            for item in self.countType{
                if (item > 0){
                    self.groups += 1
                }
            }
            let emptyObj: NSDictionary = NSDictionary()
            var i = 1
            var count = self.groups
            while (count > 0){
                for item in self.liveTrain{
                    let obj = item as NSDictionary
                    let grp = Int(obj["Group"] as! String)
                    if (grp == i){
                        self.finalTrain.append(obj)
                    }
                }
                self.finalTrain.append(emptyObj)
                i += 1
                count -= 1
            }
            print(self.finalTrain)
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return stationSelect.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return stationSelect[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reqStation = stationSelect[row]
        print(reqStation)
    }

    @IBAction func onClick(_ sender: Any) {
        returnTrain()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(self.finalTrain.count)
        self.tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveTrainTableViewCell", for: indexPath) as! LiveTrainTableViewCell
        if (self.finalTrain[indexPath.row].count > 0){
            cell.lineLabel.isHidden = false
            let destinationName = self.finalTrain[indexPath.row]["DestinationName"] as! String
            let destinationTime = self.finalTrain[indexPath.row]["Min"] as! String
            cell.destinationName.text = destinationName
            cell.destinationTime.text = destinationTime
            let color =  self.finalTrain[indexPath.row]["Line"] as! String
            cell.lineLabel.layer.cornerRadius = 0.5 * cell.lineLabel.bounds.size.width
            cell.lineLabel.layer.borderWidth = 2.0
            cell.lineLabel.frame.size = CGSize(width: 35, height: 35)
            cell.lineLabel.clipsToBounds = true
            if color == "RD"{
                cell.lineLabel.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
            } else if color == "BL"{
                cell.lineLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 255, alpha: 1.0)
            } else if color == "GR"{
                cell.lineLabel.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1.0)
            } else if color == "YL"{
                cell.lineLabel.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1.0)
            } else if color == "OR"{
                cell.lineLabel.backgroundColor = UIColor(red: 232/255, green: 108/255, blue: 41/255, alpha: 1.0)
            } else if color == "SV"{
                cell.lineLabel.backgroundColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1.0)
            }
        } else {
            cell.destinationName.text = ""
            cell.lineLabel.isHidden = true
            cell.destinationTime.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalTrain.count
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
