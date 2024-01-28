//
//  SceneDelegate.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation
import CoreLocation
import UIKit
import SwiftUI

class LocationListener: ObservableObject {
    @Published var isInZone = false
}

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    @ObservedObject var habitVM = HabitViewModel()
    
    var window: UIWindow?
    var locationListener = LocationListener()
    let locationManager = CLLocationManager()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(locationListener).environmentObject(habitVM))
            self.window = window
            window.makeKeyAndVisible()
        }
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization() // Make sure to add necessary info.plist entries
        
        self.refreshGeofences()
    }
    
    func startMonitorRegionAtLocation(center: CLLocationCoordinate2D, identifier: String) {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let maxDistance = locationManager.maximumRegionMonitoringDistance
            
            // Register the region.
            let region = CLCircularRegion(center: center,
                                          radius: maxDistance, identifier: identifier)
            region.notifyOnEntry = true
            region.notifyOnExit = true
            
            locationManager.startMonitoring(for: region)
            print("started to monitor")
        }
    }
}

extension SceneDelegate : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        locationListener.isInZone = true
        
        // Attempt to find a habit that matches the region's identifier.
        if let updatedHabit = habitVM.habitHistorys.compactMap({ habitHistory -> Habit? in
            let habitData = habitHistory.getTodaysHabitData()
            if let region = habitData.region, region.identifier == region.identifier {
                return habitHistory.getTodaysHabit()
            } else {
                return nil
            }
        }).first {
            updatedHabit.actionButtonClicked()
            habitVM.updateHabit(updatedHabit)
        } else {
            print("No matching habit found")
        }
        
        if UIApplication.shared.applicationState == .active {
            // App is open so we good bro
        } else {
            let body = "Welcome to " + region.identifier + "!"
            let notificationContent = UNMutableNotificationContent()
            notificationContent.body = body
            notificationContent.sound = .default
            notificationContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(
                identifier: "location_change",
                content: notificationContent,
                trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        locationListener.isInZone = false
        
        if UIApplication.shared.applicationState == .active {
            print("you have left")
        } else {
            let body = "You left " + region.identifier
            let notificationContent = UNMutableNotificationContent()
            notificationContent.body = body
            notificationContent.sound = .default
            notificationContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(
                identifier: "location_change",
                content: notificationContent,
                trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error: \(error)")
                }
            }
        }
    }
}

extension SceneDelegate: GeofenceSetupDelegate {
    func refreshGeofences() {
        locationManager.monitoredRegions.forEach { locationManager.stopMonitoring(for: $0) }
        
        // Setup geofence delegates on load
        for habitHistory in habitVM.habitHistorys {
            if let todaysHabit = habitHistory.getTodaysHabit() {
                let habitData = todaysHabit.toHabitData()
                if habitData.habitType == .geofencedTimeHabit || habitData.habitType == .geofencedCountHabit {
                    print("\(habitData.name) - Lat: \(habitData.region!.center.latitude) Long: \(habitData.region!.center.longitude)")
                    startMonitorRegionAtLocation(center: habitData.region!.center, identifier: habitData.region!.identifier)
                }
            }
        }
    }
}

protocol GeofenceSetupDelegate {
    func refreshGeofences()
}
