//
//  ListView.swift
//  testNetworkingServiceSwiftUI
//
//  Created by Vlad Kerov on 04.05.2021.
//

import SwiftUI

//view with list of all shots available
struct ListView: View {
    
    @State var selectedShot: Int = 0
    
    var body: some View {
        VStack() {
            Text("List of the shots").font(.largeTitle).padding()
            Picker(selection: $selectedShot, label: Text("Choose a shot:"), content: {
                ForEach(0..<shots.count){
                    Text(shots[$0].title ?? "default")
                }
            }
            )
            NavigationLink("Detailed info", destination: DetailedInfo(selectedShot: self.$selectedShot)).font(.title)
        }
    }    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
