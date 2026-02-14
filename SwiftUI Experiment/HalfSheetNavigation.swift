//
//  HalfSheetNavigation.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/14/26.
//

import SwiftUI

struct HalfSheetNavigation: View {
    @State var showSheet = false
    
    var body: some View {
        Button("Press me") {
            showSheet = true
        }
        .font(.title)
        .sheet(isPresented: $showSheet) {
            HalfSheetSubview(text: 1)
                .presentationDetents([.medium])
        }
    }
}

struct HalfSheetSubview: View {
    var text: Int
    var next: Int = (1...10).randomElement()!
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: HalfSheetSubview(text: next)) {
                    Text("Next \(next)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green.opacity(0.6))
            .navigationTitle("Title \(text)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    HalfSheetNavigation()
}
