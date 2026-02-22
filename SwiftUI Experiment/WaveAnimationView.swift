//
//  WaveAnimationView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/22/26.
//

import SwiftUI

struct WaveAnimationView: View {
    @State var currentPosition: (h: Int, v: Int) = (0,0)
    @State var trigger = false
    
    let squareSize: CGFloat
    let gridSize: (v: Int, h: Int)
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<gridSize.h, id: \.self) { vIndex in
                VStack(spacing: 8) {
                    ForEach(0..<gridSize.v, id: \.self) { hIndex in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.blue)
                            .frame(width: squareSize, height: squareSize)
                            .phaseAnimator(Phases.animationPhases, trigger: trigger) { view, state in
                                view
                                    .scaleEffect(state.scale)
                                    .opacity(state.opacity)
                                    .hueRotation(state.hue)
                                
                            } animation: { _ in
                                let d1 = Double(abs(currentPosition.h - hIndex))
                                let d2 = Double(abs(currentPosition.v - vIndex))
                                let distance = sqrt(d1 * d1 + d2 * d2)
                                
                                return .spring.delay(0.1 * distance)
                            }
                            .onTapGesture {
                                currentPosition = (hIndex, vIndex)
                                trigger.toggle()
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        WaveAnimationView(squareSize: 24, gridSize: (20, 10))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}

enum Phases {
    static let animationPhases = [Phases.initial, .expanded, .shrunk, .initial]
    
    case initial
    case expanded
    case shrunk
    
    var scale: CGFloat {
        switch self {
        case .initial:
            return 1
        case .expanded:
            return 1.2
        case .shrunk:
            return 0.7
        }
    }
    
    var opacity: CGFloat {
        switch self {
        case .initial:
            return 0.9
        case .expanded:
            return 1
        case .shrunk:
            return 0.8
        }
    }
    
    var hue: Angle {
        switch self {
        case .initial:
            return .degrees(0)
        case .expanded:
            return .degrees(180)
        case .shrunk:
            return .degrees(360)
        }
    }
}
