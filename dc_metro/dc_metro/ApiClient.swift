//
//  ApiClient.swift
//  dc_metro
//
//  Created by Aarya BC on 3/25/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import AFNetworking

class ApiClient: NSObject {
    let baseUrl = "https://api.wmata.com/Rail.svc/json/"
    let apiKey = "api_key=d88deb94540843d0bd6333440449ebe3"
    
    //to store information of all train lines
    var lines: [NSDictionary]?
    
    //to store information regarding parking at specific stations
    var stationParking: [NSDictionary]?
    var totalParkingCount = 0
    var totalParkingCost = 0
    var totalShortParking = 0
    var shortParkingNote: String!
    
    func trainLines(){
        let url = URL(string: baseUrl + "jLines/?" + apiKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.lines = dataDictionary["Lines"] as? [NSDictionary]
                }
            }
        }
        task.resume()
    }
    
    func parkingInfo(stationId: String){
        let url = URL(string: baseUrl + "jStationParking?StationCode=" + stationId + "&" + apiKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.stationParking = dataDictionary["StationsParking"] as? [NSDictionary]
//                    self.totalParkingCost = self.stationParking!
                    print(self.stationParking!)
//                    self.totalParkingCount = dataDictionary["StationsParking"][""] as? [NSDictionary]
                }
            }
        }
        task.resume()
    }
    
}
