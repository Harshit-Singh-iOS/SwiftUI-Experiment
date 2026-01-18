//
//  ContentView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/11/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    @Namespace private var animation
    @State var path: NavigationPath = NavigationPath()
    @State private var present = false
    
    // These properties don't need to be State or ObservedObject
    var user1 = User(id: 1, name: "Harry")
    var user2 = User(id: 2, name: "Hermonie")
    
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
                    .sheet(isPresented: $present) {
                        TestNavView(newView: "Presented", animation: animation)
                            .environment(ExposedUser(users: [user1, user2]))
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
                        .environment(ExposedUser(users: [user1, user2]))
                    
                }
                .navigationDestination(for: Int.self) { title in
                    TestNavView(newView: "Push Int \(title)", animation: animation)
                        .environment(ExposedUser(users: [user1, user2]))
                }
            }
            .background(.clear)
        }
        .background(.clear)
    }
}

struct TestNavView: View {
    @Environment(ExposedUser.self) var users

    var newView = ""
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            Text("New view")
                .navigationTitle(newView)
                .navigationTransition(.zoom(sourceID: newView, in: animation))
                .padding(.bottom, 80)
            
            Text(users.users[0].id.description)
            Text(users.users[0].name)
            
            Text(users.users[1].id.description)
            Text(users.users[1].name)
        }
    }
}

#Preview {
    ContentView()
}
