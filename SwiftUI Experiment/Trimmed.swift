//
//  Trimmed.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/12/26.
//

import SwiftUI

@propertyWrapper
struct Trimmed: DynamicProperty {
    @State private var value: String = ""

    var wrappedValue: String {
        get { value }
        nonmutating set {
            value = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    var projectedValue: Binding<String> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}

#Preview {
    @Previewable
    @Trimmed(wrappedValue: "") var customProperty

    
    VStack(spacing: 20) {
        Text("Trimmed Username: \(customProperty)")
            .font(.largeTitle)
        
        Button("Set New Value (with spaces)") {
            // The setter in the @Trimmed wrapper automatically cleans this string
            customProperty = "       New       "
        }
        
        TextField("Sometext", text: $customProperty)
    }
    .padding()
}
