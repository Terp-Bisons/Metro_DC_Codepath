//
//  LiveBusViewController.swift
//  dc_metro
//
//  Created by Aarya BC on 4/15/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit

class LiveBusViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var stops: Dictionary<String,String> = [:]
    var stopsToView: Array<String> = []
    var stopsNS: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        let bus = BusStationClient()
        bus.getStop(success: {(values: [NSDictionary]) -> () in
            self.stopsNS = values
            for obj in self.stopsNS{
                let name = obj["Name"] as! String
                let stopId = obj["StopID"] as! String
                if self.stops[name] == nil{
                    self.stops[name] = stopId
                    self.stopsToView.append(name)
                }
            }
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveBusCell", for: indexPath) as! LiveBusCell
        cell.stationName.text = self.stopsToView[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stopsToView.count
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let vc = segue.destination as! LiveBusDetailViewController
        vc.stopName = self.stopsToView[(indexPath?.row)!]
        
    }

}
