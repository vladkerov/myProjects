//
//  EULAView.swift
//  BMBTechSupport
//
//  Created by Vlad Kerov on 26.08.2022.
//

import SwiftUI

struct EULAView: View {
    
    @State private var eula: String = ""
    
    var body: some View {
        ScrollView{
            Text("\(eula)")
                .padding()
                .task() {
                    if let fileURL = Bundle.main.url(forResource: "eula", withExtension: "txt") {
                        do {
                            let eula = try String(contentsOf: fileURL)
                            print(eula)
                            self.eula = eula
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                }
        }
    }
}


