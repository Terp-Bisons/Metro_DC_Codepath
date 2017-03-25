//
//  ViewController.swift
//  dc_metro
//
//  Created by Aarya BC on 3/25/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let api = ApiClient()
        api.trainLines()
        api.parkingInfo(stationId: "E08")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

