//
//  appFirebaseApp.swift
//  appFirebase
//
//  Created by jimbo on 15/12/24.
//
import SwiftUI
import Firebase

@main
struct appFirebaseApp: App {
    
    @StateObject var dataManager = DataManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            
            ContentView().body.environmentObject(dataManager)
                
            
        }
    }
}
