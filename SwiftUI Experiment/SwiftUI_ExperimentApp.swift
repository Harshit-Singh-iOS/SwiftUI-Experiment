//
//  SwiftUI_ExperimentApp.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/11/26.
//

import SwiftUI

@main
struct SwiftUI_ExperimentApp: App {
    let connectivityHelper = ConnectivityHelper()
    
    var body: some Scene {
        WindowGroup {
            MatrixTapCell()
                .task {
                    connectivityHelper.startMonitoring()
                }
        }
    }
}
