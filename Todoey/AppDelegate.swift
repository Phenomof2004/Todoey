//
//  AppDelegate.swift
//  Todoey
//
//  Created by admin on 2/13/18.
//  Copyright © 2018 MVMA. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            _ = try Realm()
            
        }catch{
            print("Error initalizing new realm \(error)")
        }
        
        return true
    }
    
}
    