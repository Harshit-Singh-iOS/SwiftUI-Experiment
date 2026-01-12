//
//  TabViewTestView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/11/26.
//

import SwiftUI

enum AppTab: Hashable {
    case Home, Profile, Favorite, Settings
}

struct TabViewTestView: View {
    @Environment(\.tabViewBottomAccessoryPlacement) var tabViewBottomAccessoryPlacement
    @State var selected: AppTab = .Home
    
    var body: some View {
        TabView(selection: $selected) {
            Tab(value: AppTab.Home) {
                ZStack {
                    Color.green
                    ContentView()
                        .background(.clear)
                }
                .ignoresSafeArea()
            }
            label: {
                Image(systemName: "house")
                Text("Home")
            }
            
            Tab(value: AppTab.Profile) {
                ZStack {
                    Color.blue.opacity(1.0)
                    
                    Button("Select favorite") {
                        selected = .Favorite
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                .ignoresSafeArea()
            } label: {
                Image(systemName: "person")
                Text("Profile")
            }
            
            
            Tab("Favorite", systemImage: "heart", value: AppTab.Favorite) {
                ZStack {
                    Color.red
                    Button("Select Profile") {
                        selected = .Profile
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
                .ignoresSafeArea()
            }
            
            Tab("Setting", systemImage: "gear", value: AppTab.Settings) {
                ScrollView {
                    ZoomEffectView()
                    
                    ForEach(1..<50) { item in
                        Text("Row \(item)")
                            .frame(height: 80)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .tabViewBottomAccessory {
            tabAccessory
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        .tint(.red)
    }
    
    var tabAccessory: some View {
        if tabViewBottomAccessoryPlacement == .expanded {
            Text("Hello world!")
        } else {
            Text("Welcome to new App")
        }
    }
}

#Preview {
    TabViewTestView()
}
