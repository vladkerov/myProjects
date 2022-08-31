//
//  CheckBoxView.swift
//  CheckList2
//
//  Created by Vlad Kerov on 08.06.2022.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool
    var title:String
    func toggle(){isChecked = !isChecked
    }
    var body: some View {
        Button(action: toggle){
            HStack{
                Image(systemName: isChecked ? "checkmark.square": "square")
                Text(title)
            }

        }

    }

}

