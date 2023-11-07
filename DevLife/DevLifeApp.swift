//
//  DevLifeApp.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct DevLifeApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = AppViewModel()


  var body: some Scene {
    WindowGroup {
      NavigationView {
          TabBarView()
              .environmentObject(AttributesViewModel())
              .environmentObject(SharedDataModel())
              .environmentObject(CreditsViewModel())
              .environmentObject(viewModel)

      }
    }
  }
}
