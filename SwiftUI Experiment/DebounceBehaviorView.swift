//
//  DebounceBehaviorView.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/21/26.
//

import SwiftUI

struct DebounceBehaviorView: View {
    @State var query = ""
    @State var filteredData: [String] = []
    
    var body: some View {
        NavigationStack {
            List(0..<filteredData.count, id: \.self) { i in
                Text(filteredData[i])
            }
            .searchable(text: $query, placement: .navigationBarDrawer, prompt: "Search something")
            
            .task(id: query) {
                
                if query.isEmpty {
                    filteredData = []
                    return
                }
                
                if Task.isCancelled {
                    return
                }
                
                await searchText(text: query)
            }
        }
    }
    
    func searchText(text: String) async {
        let searchText = text.lowercased()
        try? await Task.sleep(for: .seconds(5))
        filteredData = ExampleData.data.filter({ $0.contains(searchText) })
    }
}

#Preview {
    DebounceBehaviorView()
}


fileprivate struct ExampleData {
    static let data = [
        "alpha-lorem-ipsum-dolor-sit-amet-consectetur-adipiscing-elit",
        "bravo-sed-do-eiusmod-tempor-incididunt-ut-labore-et-dolore",
        "charlie-magna-aliqua-ut-enim-ad-minim-veniam-quis-nostrud",
        "delta-exercitation-ullamco-laboris-nisi-ut-aliquip-ex-ea-commodo",
        "echo-consequat-duis-aute-irure-dolor-in-reprehenderit-in-voluptate",
        "foxtrot-velit-esse-cillum-dolore-eu-fugiat-nulla-pariatur",
        "golf-excepteur-sint-occaecat-cupidatat-non-proident-sunt-in-culpa",
        "hotel-qui-officia-deserunt-mollit-anim-id-est-laborum",
        "india-ut-aut-reiciendis-voluptatibus-maiores-alias-consequatur",
        "juliett-vel-illum-qui-dolorem-eum-fugiat-quo-voluptas-nulla",
        "kilo-pariatur-at-vero-eos-et-accusamus-et-iusto-odio-dignissimos",
        "lima-ducimus-qui-blanditiis-praesentium-voluptatum-deleniti-atque",
        "mike-corrupti-quos-dolores-et-quas-molestias-excepturi-sint",
        "november-occaecati-cupiditate-non-provident-similique-sunt",
        "oscar-in-culpa-qui-officia-deserunt-mollitia-animi-id-est",
        "papa-laborum-et-dolorum-fuga-et-harum-quidem-rerum-facilis",
        "quebec-est-et-expedita-distinctio-nam-libero-tempore-cum",
        "romeo-soluta-nobis-est-eligendi-optio-cumque-nihil-impedit",
        "sierra-quo-minus-id-quod-maxime-placeat-facere-possimus",
        "tango-omnis-voluptas-assumenda-est-omnis-dolor-repellendus",
        "uniform-temporibus-autem-quibusdam-et-aut-officiis-debitis",
        "victor-aut-rerum-necessitatibus-saepe-eveniet-ut-et-voluptates",
        "whiskey-repudiandae-sint-et-molestiae-non-recusandae-itaque",
        "xray-earum-rerum-hic-tenetur-a-sapiente-delectus-ut-aut",
        "yankee-reiciendis-voluptatibus-maiores-alias-consequatur-aut",
        "zulu-perferendis-doloribus-asperiores-repellat-saepe-eveniet",
        "data-point-27-description-of-a-very-specific-scenario-for-testing",
        "data-point-28-another-unique-string-for-performance-evaluation",
        "data-point-29-lorem-ipsum-repeats-to-simulate-realistic-data-patterns",
        "data-point-30-complex-string-containing-special-characters-like-!-@-#",
        "data-point-31-unicode-characters-to-test-encoding-and-decoding-€-¥-£",
        "data-point-32-a-long-description-of-a-product-with-many-details",
        "data-point-33-short-string-to-test-variable-length-handling",
        "data-point-34-an-address-line-with-numbers-and-street-names",
        "data-point-35-json-snippet-within-a-string-for-parsing-tests-{\"key\":\"value\"}",
        "data-point-36-empty-string-for-edge-case-testing",
        "data-point-37-string-with-many-commas-separated,values,to,test,split,functions",
        "data-point-38-a-sentence-with-many-spaces-to-test-trimming-functions",
        "data-point-39-hexadecimal-data-representation-0xdeadbeef-0x12345678",
        "data-point-40-base64-encoded-string-Zm9vYmFyYmF6",
    ]

}
