//
//  ZoomEffectView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/11/26.
//

import SwiftUI

struct Icon: Identifiable {
    var id: String
    var color: Color
}

struct ZoomEffectView: View {
    let icons = [
        Icon(id: "figure.badminton", color: .red),
        Icon(id: "figure.fencing", color: .orange),
        Icon(id: "figure.gymnastics", color: .green),
        Icon(id: "figure.indoor.cycle", color: .blue),
        Icon(id: "figure.outdoor.cycle", color: .purple),
        Icon(id: "figure.rower", color: .indigo),
    ]

    @Namespace var animation
    @State private var selected: Icon?

    var body: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: 300))]) {
            ForEach(icons) { icon in
                Button {
                    selected = icon
                } label: {
                    Image(systemName: icon.id)
                }
                .foregroundStyle(icon.color.gradient)
                .font(.system(size: 100))
                .matchedTransitionSource(id: icon.id, in: animation)
            }
        }
        .sheet(item: $selected) { icon in
            DestinationView(icon: icon, animation: animation)
        }
    }
}

struct DestinationView: View {
    var icon: Icon
    var animation: Namespace.ID

    var body: some View {
        Image(systemName: icon.id)
            .font(.system(size: 300))
            .foregroundStyle(icon.color.gradient)
            .navigationTransition(.zoom(sourceID: icon.id, in: animation))
    }
}


#Preview {
    ZoomEffectView()
}
