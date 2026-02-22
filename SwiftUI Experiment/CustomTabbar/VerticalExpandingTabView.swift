//
//  VerticalExpandingTabView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/22/26.
//

import SwiftUI

struct VerticalExpandingTabView: View {
    @Binding var selectedTab: MyAppTab
    @State private var isExpanded = false
    
    var body: some View {
        ZStack {
            ForEach(0..<MyAppTab.allCases.count, id: \.self) { index in
                let tab = MyAppTab.allCases[index]
                
                Button {
                    withAnimation {
                        selectedTab = tab
                        isExpanded.toggle()
                    }
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
                .offset(y: CGFloat(-80 * (index + 1) * (isExpanded ? 1 : 0)))
            }
            
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
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
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        .padding(.trailing, 24)
    }
}

#Preview {
    @Previewable @State var tab = MyAppTab.Home
    VerticalExpandingTabView(selectedTab: $tab)
}
