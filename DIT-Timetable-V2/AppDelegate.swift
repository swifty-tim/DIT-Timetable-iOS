//
//  AppDelegate.swift
//  DIT-Timetable-V2
//
//  Created by Timothy Barnard on 15/09/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //self.sendRawTimetable()
        let (colRed, colGreen, colBlue) = self.readFromJSON()
        
        //238, 50, 51
        let navColor = UIColor(red: CGFloat(colRed)/255, green: CGFloat(colGreen)/255.0, blue: CGFloat(colBlue)/255.0, alpha: 0.5)
       // let navColor = UIColor(red: 38.0/255, green: 154.0/255, blue: 208.0/255, alpha: 0.5)
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = navColor
        UINavigationBar.appearance().isTranslucent = true
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName: UIFont(name: "Avenir Next", size: 22)!]
       
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let database = Database()
        
        let userDefaults = UserDefaults.standard
        let TimetableHelp = userDefaults.bool(forKey: "TimetableHelp")
        
        // if we haven't shown the walkthroughs, let's show them
        if !TimetableHelp {
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            var storyboard = UIStoryboard()
            
            if ( UIDevice.current.userInterfaceIdiom == .pad  ) {
                storyboard = UIStoryboard(name: "StoryboardiPad", bundle: nil)
            } else {
                storyboard = UIStoryboard(name: "Main", bundle: nil)
            }
            
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "HelpPageViewController")
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()

        } else {
            
            if database.getSavedClassesCount() == 0 {
                
                self.window = UIWindow(frame: UIScreen.main.bounds)
                
                var storyboard = UIStoryboard()
                
                if ( UIDevice.current.userInterfaceIdiom == .pad  ) {
                    storyboard = UIStoryboard(name: "StoryboardiPad", bundle: nil)
                } else {
                    storyboard = UIStoryboard(name: "Main", bundle: nil)
                }
                
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }
        }
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func readFromJSON() -> (Float, Float, Float) {
        print("readFromJSON")
        //print(MyFileManager.readJSONFile(parseKey: "maps", keyVal: "id"))
        return MyFileManager.readJSONColor(parseKey: "navColor", keyVal: "", defaultCode: (38.0, 154.0, 208.0) )
    }
    
}

