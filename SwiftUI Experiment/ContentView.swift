//
//  ContentView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/11/26.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    @State var path: NavigationPath = NavigationPath()
    @State private var present = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    Rectangle()
                        .fill(.blue)
                        .clipShape(.rect(cornerRadii: .init(topLeading: 50, bottomLeading: 50, bottomTrailing: 200, topTrailing: 10)))
                        .frame(width: 300, height: 300)
                    
                    Rectangle()
                        .fill(.red)
                        .clipShape(.rect(cornerRadius: 20), style: .init(eoFill: false))
                        .frame(width: 300, height: 300)
                    
                    Button("Present") {
                        present = true
                    }
                    .navigationDestination(isPresented: $present) {
                        TestNavView(newView: "Presented", animation: animation)
                            .matchedTransitionSource(id: "1", in: animation)
                    }
                    
                    Button("Push String") {
                        path.append("New view 1")
                    }
                    
                    Button("Push Integer") {
                        path.append(5)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .navigationDestination(for: String.self) { title in
                    TestNavView(newView: title, animation: animation)
                }
                .navigationDestination(for: Int.self) { title in
                    TestNavView(newView: "Push Int \(title)", animation: animation)
                }
            }
            .background(.clear)
        }
        .background(.clear)
    }
}

struct TestNavView: View {
    var newView = ""
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            Text("New view")
                .navigationTitle(newView)
                .navigationTransition(.zoom(sourceID: newView, in: animation))
        }
    }
}

#Preview {
    ContentView()
}
