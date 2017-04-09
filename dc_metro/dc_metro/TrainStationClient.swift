//
//  TrainStationClient.swift
//  dc_metro
//
//  Created by Aarya BC on 4/8/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import AFNetworking

class TrainStationClient: NSObject {
    let baseUrl = "https://api.wmata.com/Rail.svc/json/"
    let apiKey = "api_key=d88deb94540843d0bd6333440449ebe3"
    
    //to store information of all train lines
    var lines: [NSDictionary]? = []
    
    //to store information regarding parking at specific stations
    var stationParking: [NSDictionary]?
    var totalParkingCount = 0
    var totalParkingCost = 0
    var shortParkingNote: String!
    
    //to store information regarding the path between two stations
    var pathBetweenTwo: [NSArray]?
    
    func trainLines() -> [NSDictionary]{
//        var lines: [NSDictionary]? = []
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
        return self.lines!
    }
    
    func parkingInfo(stationId: String){
        let url = URL(string: baseUrl + "jStationParking?StationCode=" + stationId + "&" + apiKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.stationParking = dataDictionary["StationsParking"] as? [NSDictionary]
                    let allDayParking = self.stationParking?[0]["AllDayParking"] as? NSDictionary
                    self.totalParkingCost = allDayParking?["RiderCost"] as! Int
                    self.totalParkingCount = allDayParking?["TotalCount"] as! Int
                }
            }
        }
        task.resume()
    }
    
    func pathBetweenTwoStations(station1Id: String, station2Id: String){
        let url = URL(string: baseUrl + "jPath?FromStationCode=" + station1Id + "&ToStationCode=" + station2Id + "&" + apiKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataArray = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.pathBetweenTwo = dataArray["Path"] as? [NSArray]
                }
            }
        }
        task.resume()
    }
    
    

}
