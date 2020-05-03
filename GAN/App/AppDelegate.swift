//
//  AppDelegate.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties

    var window: UIWindow?
    
    // MARK: - Lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else {
            fatalError("No UI Window") 
        }
        
        self.window = window
        
        let network = NetworkSession(session: URLSession.shared, domain: "https://breakingbadapi.com")
        let repository = Repository(network: network)
        let factory = CoordinatorFactory(repository: repository)
        let coordinator = factory.makeCharacters()
        coordinator.start(on: window)
    
        return true
    }
}

