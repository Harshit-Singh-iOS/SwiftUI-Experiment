//
//  SemiCircleExpandingTabbar.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/22/26.
//

import SwiftUI

struct SemiCircleExpandingTabbar: View {
    @Binding var selectedTab: MyAppTab
    @State private var isExpanded = false
    let radius: CGFloat = 100.0
    
    var body: some View {
        ZStack {
            ForEach(0..<MyAppTab.allCases.count, id: \.self) { index in
                let tab = MyAppTab.allCases[index]
                let angle = angleForTab(at: index, total: MyAppTab.allCases.count)
                
                Button {
                    selectedTab = tab
                    isExpanded.toggle()
                } label: {
                    VStack {
                        Image(systemName: tab.systemImage)
                            .scaledToFit()
                        Text(tab.title)
                            .font(.caption)
                    }
                    .foregroundStyle(.black)
                    .frame(width: 60, height: 60)
                    .background(tab.color)
                    .clipShape(.circle)
                }
                .offset(
                    x: isExpanded ? 0 : cos(angle.radians) * radius,
                    y: isExpanded ? 0 : sin(angle.radians) * radius
                )
                .animation(.spring, value: isExpanded)
            }
            
            Button {
                isExpanded.toggle()
            } label: {
                VStack {
                    Image(systemName: selectedTab.systemImage)
                        .scaledToFit()
                    Text(selectedTab.title)
                        .font(.caption)
                }
                .foregroundStyle(.black)
                .frame(width: 60, height: 60)
                .background(selectedTab.color)
                .clipShape(.circle)
            }
            .scaleEffect(isExpanded ? 1.2 : 1)
        }
    }
    
    func angleForTab(at index: Int, total: Int) -> Angle {
        if total <= 1 { return .degrees(90) }
        
        let totalArc = 180
        let eachAngle = Double(totalArc) / Double(total-1)
        let current = Double(index) * eachAngle
        let start = 180.0
        
        return .degrees(start + current)
    }
}

#Preview {
    @Previewable @State var tab = MyAppTab.Home
    SemiCircleExpandingTabbar(selectedTab: $tab)
}
