//
//  BusStationClient.swift
//  dc_metro
//
//  Created by Pratyush Thapa on 4/15/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class BusStationClient: BDBOAuth1SessionManager {
    let baseUrl = "https://api.wmata.com/Bus.svc/json/"
    let apiKey = "api_key=d88deb94540843d0bd6333440449ebe3"
    
    var route: [NSDictionary]? = []
    
    func busStationroute(success: @escaping ([NSDictionary])->()){
        let url = URL(string: baseUrl + "jLines/?" + apiKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.route = dataDictionary["Lines"] as? [NSDictionary]
                }
            }
        }
        task.resume()
        success(self.route!)
    }

}
