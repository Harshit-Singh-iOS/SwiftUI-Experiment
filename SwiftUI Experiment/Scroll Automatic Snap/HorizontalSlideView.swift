//
//  HorizontalSlideView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 2/21/26.
//

import SwiftUI

@Observable
class HorizontalSlideVM {
    let data: [String] = [
        "https://images.pexels.com/photos/4094252/pexels-photo-4094252.jpeg",
        "https://images.pexels.com/photos/2308893/pexels-photo-2308893.jpeg",
        "https://images.pexels.com/photos/6913576/pexels-photo-6913576.jpeg",
        "https://images.pexels.com/photos/9544524/pexels-photo-9544524.jpeg",
        "https://images.pexels.com/photos/4017166/pexels-photo-4017166.jpeg"
    ]
    
    var images: [UIImage?] = []
    
    init() {
        self.images = Array(repeating: nil, count: 5)
    }
    
    func fetchImage(at index: Int) {
        Task.detached {
            if let url = URL(string: self.data[index]),
               let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                Task { @MainActor in
                    self.images[index] = image
                }
            }
        }
    }
}

struct HorizontalSlideView: View {
    let selected: Int
    @State var vm = HorizontalSlideVM()
    @State var position: Int?
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<vm.images.count, id: \.self) { index in
                            AsyncImage(url: URL(string: vm.data[index])) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width, height: geo.size.height)
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width, height: geo.size.height)
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                .scrollPosition(id: $position, anchor: .leading)
            }
            .navigationTitle("Images")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                position = self.selected
            }
        }
    }
}

#Preview {
    HorizontalSlideView(selected: 3)
}
