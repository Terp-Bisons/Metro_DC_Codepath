//
//  BusStationClient.swift
//  dc_metro
//
//  Created by Pratyush Thapa on 4/15/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import CoreLocation


//https://api.wmata.com/Bus.svc/json/jStops?Lat=38.878586&Lon=-76.989626&Radius=500&api_key=d88deb94540843d0bd6333440449ebe3
class BusStationClient: BDBOAuth1SessionManager {
    let baseUrl = "https://api.wmata.com/Bus.svc/json/"
    let apiKey = "api_key=d88deb94540843d0bd6333440449ebe3"
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var route: [NSDictionary]? = []
    var liveRoute: [NSDictionary]? = []
    
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
    
    func getLocation(success: @escaping ([String])->()) {
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            let lat = String(currentLocation.coordinate.latitude)
            let lon = String(currentLocation.coordinate.longitude)
            success([lat, lon])
        }
    }
    
    func getStop(success: @escaping ([NSDictionary]) -> ()) {
        var location: [String] = []
        getLocation(success: {(values: [String]) -> () in
            location = values
        })
        let lat = location[0]
        let lon = location[1]
        let radius = "250"
        let url = URL(string: baseUrl + "jStops/?Lat=" + lat + "&Lon=" + lon + "&Radius=" + radius + "&" + apiKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    let stops = dataDictionary["Stops"] as? [NSDictionary]
                    success(stops!)
                }
            }
        }
        task.resume()
    }
    
    func getLiveBus(stationId: String, success: @escaping ([NSDictionary]) -> ()) {
        let url = URL(string: "https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=" + stationId + "&" + apiKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.liveRoute = dataDictionary["Predictions"] as? [NSDictionary]
                    success(self.liveRoute!)
                }
            }
        }
        task.resume()
    }
    
}
