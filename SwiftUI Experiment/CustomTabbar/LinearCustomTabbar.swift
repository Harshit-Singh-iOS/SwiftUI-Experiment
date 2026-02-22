//
//  LinearCustomTabbar.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/22/26.
//

import SwiftUI

struct LinearCustomTabbar: View {
    @Binding var selectedTab: MyAppTab
    
    var body: some View {
        HStack {
            ForEach(MyAppTab.allCases) { tab in
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
                    .background(tab.color)
                    .clipShape(.circle)
                }
                .glassEffect()
                .overlay {
                    if tab == selectedTab {
                        Circle()
                            .stroke(.black, lineWidth: 4)
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var tab = MyAppTab.Home
    LinearCustomTabbar(selectedTab: $tab)
        .padding()
}
