//
//  CheckListModel.swift
//  CheckList2
//
//  Created by Vlad Kerov on 07.06.2022.
//

import Foundation


class CheckListModel: ObservableObject {
    
    static let shared = CheckListModel()

    @Published var checkListStructure = [(String?, String, Bool)]()
    
    func transformArrayForSaving () -> [[String]]{
        var outArray = [[String]]()
        let inArray = self.checkListStructure
        inArray.forEach{
            let section = $0.0 ?? ""
        let text = $0.1
        let mark = String($0.2)
            let subArray = [section, text, mark]
            outArray.append(subArray)
        }
        return outArray
        
    }
    
    func transformArrayAfterLoading(array: [[String]]) -> Void {
        self.reset()
        array.forEach{
            let section: String?
            let text: String
            let mark: Bool
            
            if $0[0] == "" {
                section = nil
            } else {section = $0[0]}
            
            text = $0[1]
            
            switch $0[2] {
            case "false": mark = false
            case "true": mark = true
            default: mark = false
            }
            self.checkListStructure.append((section, text, mark))
        }
    }
    
    
    func reset(){
        self.checkListStructure.removeAll()        
    }
}




