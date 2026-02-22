//
//  TestScrollTarget.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/21/26.
//

import SwiftUI

struct ScrollSnapView: View {
    @State var vm = ScrollSnapVM()
    
    var body: some View {
        VStack {
            Spacer()
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(vm.dataForView, id: \.id) { data in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(data.color)
                            .frame(height: 200)
                            .containerRelativeFrame(.horizontal) { width, axis in
                                width * 0.88
                            }
                    }
                }
                .padding()
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $vm.scrollPosition, anchor: .leading)
            
            Toggle("Auto scroll", isOn: $vm.autoScroll).padding()
                .onChange(of: vm.autoScroll) { _, newValue in
                    vm.updateTimer(on: newValue)
                }
            
            HStack {
                Text("Selected data")
                Spacer()
                
                Picker("Selected Dataset", selection: .init(get: {
                    vm.selected
                }, set: { index in
                    vm.selected = index
                })) {
                    ForEach(0..<vm.totalItemSet, id: \.self) { index in
                        Text("Data \(index)")
                    }
                }
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    ScrollSnapView()
}

@Observable
class ScrollSnapVM {
    private var data: [[CardData]] = CardData.exampleArray
    var totalItemSet: Int { data.count }
    
    var selected = 0
    var scrollPosition: UUID?
    
    var autoScroll = false
    var timer: Timer?
    
    var dataForView: [CardData] {
        data[selected]
    }
    
    func updateTimer(on: Bool) {
        guard on else {
            timer?.invalidate()
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            
            var index = self.dataForView.firstIndex(where: { $0.id == self.scrollPosition ?? UUID() }) ?? -1
            
            if index == self.dataForView.count - 1 {
                index = -1
            }
            
            withAnimation {
                self.scrollPosition = self.dataForView[index + 1].id
            }
        })
    }
}


struct CardData: Identifiable {
    var id = UUID()
    var color: Color
    
    static let exampleArray: [[CardData]] = [
        [.init(color: .red), .init(color: .green), .init(color: .blue), .init(color: .red), .init(color: .green), .init(color: .blue), .init(color: .red), .init(color: .green), .init(color: .blue), .init(color: .red), .init(color: .green), .init(color: .blue), .init(color: .red), .init(color: .green), .init(color: .blue), .init(color: .red), .init(color: .green), .init(color: .blue), .init(color: .red), .init(color: .green), .init(color: .blue), .init(color: .red), .init(color: .green), .init(color: .blue), .init(color: .red), .init(color: .green), .init(color: .blue), .init(color: .red), .init(color: .green), .init(color: .blue)],
        
        [.init(color: .yellow), .init(color: .pink), .init(color: .gray), .init(color: .brown), .init(color: .yellow), .init(color: .pink), .init(color: .gray), .init(color: .brown), .init(color: .yellow), .init(color: .pink), .init(color: .gray), .init(color: .brown), .init(color: .yellow), .init(color: .pink), .init(color: .gray), .init(color: .brown), .init(color: .yellow), .init(color: .pink), .init(color: .gray), .init(color: .brown), .init(color: .yellow), .init(color: .pink), .init(color: .gray), .init(color: .brown), .init(color: .yellow), .init(color: .pink), .init(color: .gray), .init(color: .brown), .init(color: .yellow), .init(color: .pink), .init(color: .gray), .init(color: .brown)],
        
        [.init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black), .init(color: .orange), .init(color: .purple), .init(color: .black)]
    ]
}
