//
//  MyTabView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/22/26.
//

import SwiftUI

enum MyAppTab: Hashable, CaseIterable, Identifiable {
    case Home, Profile, Favorite, Star, Settings
    
    var id: String { title }
    
    var title: String {
        switch self {
        case .Home: return "Home"
        case .Profile: return "Profile"
        case .Favorite: return "Favorite"
        case .Settings: return "Settings"
        case .Star: return "Starred"
        }
    }
    
    var systemImage: String {
        switch self {
        case .Home: return "house"
        case .Profile: return "person"
        case .Favorite: return "heart"
        case .Star: return "star"
        case .Settings: return "gear"
        }
    }
    
    var color: Color {
        switch self {
        case .Home: return .blue
        case .Profile: return .red
        case .Favorite: return .yellow
        case .Star: return .green
        case .Settings: return .purple
        }
    }
}

struct MyTabView: View {
    @State private var selectedTab: MyAppTab = .Home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(MyAppTab.allCases) { tab in
                VStack {
                    Image(systemName: tab.systemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    Text(tab.title)
                        .font(.largeTitle)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(tab.color.opacity(0.5))
                .tabItem { Label(tab.title, systemImage: tab.systemImage) }
                .tag(tab)
            }
            .toolbarVisibility(.hidden, for: .tabBar)
        }
        .safeAreaInset(edge: .bottom) {
//            LinearCustomTabbar(selectedTab: $selectedTab)
//            VerticalExpandingTabView(selectedTab: $selectedTab)
            SemiCircleExpandingTabbar(selectedTab: $selectedTab)
//            CutOutStyleTabbar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    MyTabView()
}
