//
//  DetailedInfo.swift
//  testNetworkingServiceSwiftUI
//
//  Created by Vlad Kerov on 04.05.2021.
//

import SwiftUI
//view with detailed info of certain chosen shot
struct DetailedInfo: View {
    
    @Binding var selectedShot: Int
    
    var body: some View {
        VStack{
            let detailedInfoImage = shots[selectedShot].image_url ?? ""
            RemoteImage(url: detailedInfoImage)
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 300).cornerRadius(25).onAppear().animation(.interactiveSpring(response: 0.9, dampingFraction: 0.2, blendDuration: 0.25))
            Text("Detailed Info:").font(.title2).onAppear().animation(.easeOut(duration: 2))
            VStack{
                Text("Title: \(shots[selectedShot].title ?? "no title")")
            Text("Description: \(shots[selectedShot].description ?? "no description")")
            Text("Published at: \(shots[selectedShot].published_at ?? "no info")")
            Text("Updated at: \(shots[selectedShot].updated_at ?? "no info")")
//            Text("Width: \(shots[selectedShot].width ?? "no info")")
//            Text("Height: \(shots[selectedShot].height ?? "no info")")
            }.foregroundColor(.blue).font(.footnote).onAppear().animation(.easeOut(duration: 1).repeatCount(3, autoreverses: true))
        }
    }
}

struct DetailedInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailedInfo(selectedShot: .constant(0))
    }
}
