//
//  GridExpandingTabView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/28/26.
//

import SwiftUI

struct GridExpandingTabView: View {
    @Binding var selectedTab: MyAppTab
    @State private var isExpanded = false
    
    var body: some View {
        let allTabs = MyAppTab.allCases.sorted(by: {
            if $0 == selectedTab {
                return false
            } else if $1 == selectedTab {
                return true
            } else {
                return $0.title < $1.title
            }
        })
        
        return VStack {
            if isExpanded {
                HStack {
                    ForEach(allTabs[..<3]) { tab in
                        viewFor(tab: tab) {
                            withAnimation {
                                selectedTab = tab
                                isExpanded = false
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    ForEach(allTabs[..<3]) { tab in
                        viewFor(tab: tab) {
                            withAnimation {
                                selectedTab = tab
                                isExpanded = false
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    ForEach(allTabs[..<3]) { tab in
                        viewFor(tab: tab) {
                            withAnimation {
                                selectedTab = tab
                                isExpanded = false
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            HStack {
                ForEach(allTabs[3...]) { tab in
                    viewFor(tab: tab) {
                        withAnimation {
                            selectedTab = tab
                            isExpanded = false
                        }
                    }
                }
                
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    VStack {
                        Image(systemName: "square.stack.3d.up")
                            .scaledToFit()
                        Text("More")
                            .font(.caption)
                    }
                    .foregroundStyle(.black)
                    .frame(width: 60, height: 60)
                    .background(.gray)
                    .clipShape(.circle)
                }
                .animation(.spring, value: isExpanded)
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func viewFor(tab: MyAppTab, action: (() -> Void)?) -> some View {
        Button {
            action?()
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
        .animation(.spring, value: isExpanded)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    @Previewable @State var tab = MyAppTab.Home
    VStack {
        Spacer()
        GridExpandingTabView(selectedTab: $tab)
    }
    .frame(maxWidth: .infinity)
    .background(tab.color.opacity(0.5))
}
