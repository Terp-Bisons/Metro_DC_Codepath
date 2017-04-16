//
//  TrainStationClient.swift
//  dc_metro
//
//  Created by Aarya BC on 4/8/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

class TrainStationClient: BDBOAuth1SessionManager{
    let baseUrl = "https://api.wmata.com/Rail.svc/json/"
    let apiKey = "api_key=d88deb94540843d0bd6333440449ebe3"
   // static let sharedInstance = TrainStationClient(baseURL: NSURL(string:"https://api.wmata.com/Rail.svc/json/")! as URL!, consumerKey: "api_key=d88deb94540843d0bd6333440449ebe3", consumerSecret: nil)
    //static let sharedInstance = TwitterClient(baseURL: NSURL(string:"https://api.twitter.com")! as URL!, consumerKey: "xUgm852TuX3mcJG7Nfhyw0poo", consumerSecret: "UF9V6RImOjAXUTjJVWWEAcFkieHjO4Rv7wncuKPeMBDOG0A0wJ")
    
    //to store information of all train lines
    static var lines: [NSDictionary]? = []
    
    //to store information regarding parking at specific stations
    var stationParking: [NSDictionary]?
    var totalParkingCount = 0
    var totalParkingCost = 0
    var shortParkingNote: String!
    
    //to store information regarding the path between two stations
    var pathBetweenTwo: [NSArray]?
    
    func trainLines(success: @escaping ([NSDictionary])->()){
        var lines: [NSDictionary]? = []
        //let trainlinessharedInstance = TrainStationClient(baseURL: NSURL(string:"https://api.wmata.com/Rail.svc/json/jLines/?")! as URL!, consumerKey: "api_key=d88deb94540843d0bd6333440449ebe3", consumerSecret: nil)
        let url = URL(string: baseUrl + "jLines/?" + apiKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    TrainStationClient.lines = dataDictionary["Lines"] as? [NSDictionary]
                    print(TrainStationClient.lines!)
                }
            }
        }
        task.resume()
<<<<<<< HEAD
        return TrainStationClient.lines!
=======
        success(self.lines!)
>>>>>>> 82c0d8bdc067e979bedc7ab5284ab795f225d782
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
