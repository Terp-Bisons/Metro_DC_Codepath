//
//  TripPlannerHelperViewController.swift
//  dc_metro
//
//  Created by Aarya BC on 4/23/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit

class TripPlannerHelperViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    //var data: Data? = nil
    @IBOutlet var tableView: UITableView!
    var directionsteps: Array<String> = []
    var from: String!
    var to: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        print(from)
        print(to)
        passValue()
        // Do any additional setup after loading the view.
    }
    
    
    func passValue(){
        let finalURL = "https://maps.googleapis.com/maps/api/directions/json?origin="+from!+"&destination="+to!+"&mode=transit&key=AIzaSyB6DH0ejiUg7MnATbqpOXRC-Hh-vQ2jsFs"
        let url = URL(string: finalURL)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //        print(request)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            //            print("success")
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    var instructions = dataDictionary["routes"] as! [NSDictionary]
                    var legs = instructions[0]["legs"] as! [NSDictionary]
                    let steps = legs[0]["steps"] as! [NSDictionary]
                    for item in steps{
                        let obj = item
                        self.directionsteps.append((obj["html_instructions"] as? String)!)
                        //                        print(obj["html_instructions"] as! String)
                        if (obj["travel_mode"] as! String == "TRANSIT"){
                            let transitDetails = obj["transit_details"] as! NSDictionary
                            let arrivalStop = transitDetails["arrival_stop"] as! NSDictionary
                            self.directionsteps.append("The final stop is " + (arrivalStop["name"] as? String)!)
                            //                            print("The final stop is " + (arrivalStop["name"] as! String))
                        }
                    }
                    print(self.directionsteps)
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripHelperCell", for: indexPath) as! TripHelperCell
        //        print(self.directionsteps[indexPath.row])
        cell.directionLabel.text = self.directionsteps[indexPath.row]
        let label = self.directionsteps[indexPath.row]
        if (label.lowercased().range(of:"train") != nil){
            print("train exists")
            cell.directionImage.image = UIImage(named: "underground")
            cell.directionImage.tintColor = UIColor.red
        }
        else if (label.lowercased().range(of:"metro") != nil)
        {
            print("metro is present")
            cell.directionImage.image = UIImage(named: "underground")
            cell.directionImage.tintColor = UIColor.red
        }
        else if (label.lowercased().range(of:"stop") != nil)
        {
            print("bus stop is present")
            cell.directionImage.image = UIImage(named: "bus-stop")
            cell.directionImage.tintColor = UIColor.blue
        }
        else if (label.lowercased().range(of:"bus") != nil)
        {
            print("bus is present")
            cell.directionImage.image = UIImage(named: "bus-side-view")
            cell.directionImage.tintColor = UIColor.gray
        }
        else
        {
            print("walk is present")
            cell.directionImage.image = UIImage(named: "pedestrian-walking")
            cell.directionImage.tintColor = UIColor.black
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directionsteps.count
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
