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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        }
    }
    
    
}
