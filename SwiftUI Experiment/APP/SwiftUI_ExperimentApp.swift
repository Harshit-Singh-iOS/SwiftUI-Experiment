//
//  SwiftUI_ExperimentApp.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/11/26.
//

import SwiftUI
import BackgroundTasks

@main
struct SwiftUI_ExperimentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate
    
    let connectivityHelper = ConnectivityHelper()
    var body: some Scene {
        WindowGroup {
            ScrollSnapView()
                .task {
                    connectivityHelper.startMonitoring()
                }
                .task {
//                    BGTaskScheduler.shared.register(forTaskWithIdentifier: "FIRST BACKGROUND TASK", using: nil) { task in
//                        print("Task app refresh starting")
//                        self.handleAppRefresh(task: task as! BGAppRefreshTask)
//                    }
                }
                .onOpenURL { url in
                    print(url)
                    if let comp = URLComponents(string: url.absoluteString) {
                        print(comp.path)
                        print(comp.scheme)
                        print(comp.queryItems)
                        print(comp.host)
                    }
                }
        }
        .backgroundTask(.appRefresh("FIRST BACKGROUND TASK")) { task in
            print("DOING SOMETHING HERE")
            await handleAppRefresh()
        }
    }
    
    func handleAppRefresh() {
//    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        // Perform your background operation
        print("Task app refresh scheduled")
//        task.setTaskCompleted(success: true)
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "FIRST BACKGROUND TASK")
//        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // 15 minutes
        request.earliestBeginDate = .now + 5
        
        do {
            print("Task app refresh works")
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Failed to submit request: \(error)")
        }
    }
    
    
//    func setupBackgroudTask(task: BGAppRefreshTask) {
//        let request = BGAppRefreshTaskRequest(identifier: "harshit.SwiftUI-Experiment")
//        // Optional: set an earliest begin date (system decides the actual time after this date)
//        //        request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60 * 60) // not sooner than 1 hour
//        request.earliestBeginDate = .now
//        
//        do {
//            try BGTaskScheduler.shared.submit(request)
//            
//            for i in 1..<100 {
//                //                    try? await Task.sleep(for: .seconds(1))
//                print("Threat at index \(i)")
//            }
//            
//            print("Background task scheduled")
//        } catch {
//            print("Could not schedule task: \(error.localizedDescription)")
//        }
//    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        print("******* AppDelegate Launch the app delegate ******")
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self // Specify your custom SceneDelegate
        return config
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("******* SceneDelegate sceneDidBecomeActive ******")
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("******* SceneDelegate scene openURLContexts ******")
        print(URLContexts.first?.url ?? "No url")
    }
}
