//
//  CutOutStyleTabbar.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/22/26.
//

import SwiftUI

struct CutOutStyleTabbar: View {
    @Binding var selectedTab: MyAppTab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<MyAppTab.allCases.count, id: \.self) { index in
                let tab = MyAppTab.allCases[index]
                
                if index == MyAppTab.allCases.count / 2 {
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 80, bottomTrailingRadius: 80, topTrailingRadius: 0, style: .continuous)
                        .fill(selectedTab.color.opacity(0.5))
                        .frame(width: 80)
                        .padding([.horizontal, .bottom])
                        .overlay(alignment: .top) {
                            tabFor(tab)
                                .offset(y: -24)
                        }
                } else {
                    tabFor(tab)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.white)
    }
    
    func tabFor(_ tab: MyAppTab) -> some View {
        Button {
            withAnimation {
                selectedTab = tab
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
            .clipShape(.rect(cornerRadius: 8))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var tab = MyAppTab.Home
    VStack {
        Spacer()
        CutOutStyleTabbar(selectedTab: $tab)
    }
    .background(tab.color.opacity(0.5))
    
}
