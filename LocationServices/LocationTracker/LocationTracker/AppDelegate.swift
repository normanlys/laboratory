//
//  AppDelegate.swift
//  LocationTracker
//
//  Created by Norman Lim on 13/7/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        return true
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard let viewController = window?.rootViewController as? ViewController else {
            print("failed")
            return
        }
        
        let task = URLSession.shared.dataTask(with: URL(string: "http://worldtimeapi.org/api/ip")!) { (data, _, error) in
            guard let data = data, error == nil else { return }
            let dataString = String(data: data, encoding: .utf8)
            DispatchQueue.main.async(execute: {
                viewController.datetimeLabel.text = dataString ?? "no data"
            })
            UserDefaults.standard.set(dataString, forKey: "datetime")
            completionHandler(.newData)
        }
        task.resume()
    }
    
    
}

