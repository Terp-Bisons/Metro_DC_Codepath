//
//  TripPlannerViewController.swift
//  dc_metro
//
//  Created by Aarya BC on 4/15/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

class TripPlannerViewController: UIViewController{
    @IBOutlet weak var fromText: UITextField!
    @IBOutlet weak var butt: UIButton!
    @IBOutlet weak var toText: UITextField!
    var apiKey = "AIzaSyB6DH0ejiUg7MnATbqpOXRC-Hh-vQ2jsFs"
    var segSteps: [NSDictionary] = []
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var switch_val: UISwitch!
    
    
    @IBOutlet weak var viewdatepicker: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        datepicker.isHidden = true
        switch_val.addTarget(self, action: #selector(switchIsChanged(switch_val:)), for: UIControlEvents.valueChanged)
        datepicker.timeZone = NSTimeZone.local
        // Do any additional setup after loading the view.
    }
    
    func switchIsChanged(switch_val: UISwitch) {
        if switch_val.isOn {
            datepicker.isHidden = false
        } else {
            datepicker.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPress(_ sender: Any) {
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "tripplannerhelper"{
            let vc = segue.destination as! TripPlannerHelperViewController
            vc.from = fromText.text?.replacingOccurrences(of:" ", with:"+")
            vc.to = toText.text?.replacingOccurrences(of:" ", with:"+")
            vc.show_arrival_time = switch_val.isOn
            datepicker.timeZone = NSTimeZone.local
            vc.arrive_by = datepicker.date.timeIntervalSince1970 - 14400
        }
    }
    
    
}
