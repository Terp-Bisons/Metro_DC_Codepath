//
//  LiveBusDetailViewController.swift
//  dc_metro
//
//  Created by Aarya BC on 4/23/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit

class LiveBusDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate {
    
    var stopName : String!
    var stopID: String!
    var liveBus: [NSDictionary] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let liveBus = BusStationClient()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
        print(stopID)
        liveBus.getLiveBus(stationId: self.stopID, success: {(line: [NSDictionary])->() in
            print(line)
            self.liveBus = line
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveBusDetailTableViewCell", for: indexPath) as! LiveBusDetailTableViewCell
        let directionText = self.liveBus[indexPath.row]["DirectionText"] as! String
        let time = "\(self.liveBus[indexPath.row]["Minutes"] as! Int)"
        cell.directionTime.text = time
        cell.directionName.text = directionText
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.liveBus.count)
        return self.liveBus.count
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
