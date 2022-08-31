//
//  ContentView.swift
//  CheckList2
//
//  Created by Vlad Kerov on 07.06.2022.
//

import SwiftUI
import ActivityView
import SwiftyJSON


struct ContentView: View {
    //    check list model:
    @StateObject var checkListModel = CheckListModel.shared
    //    item for sharing:
    @State private var item: ActivityItem?
    //    section naming alert trigger:
    @State private var isRenameAlertPresented = false
    //    file loading trigger:
    @State var isLoading = false
    
    var body: some View {

        NavigationView{

            ScrollView{

                VStack{
//                    Text("Check list")
//                        .foregroundColor(Color(.systemBlue))
//                        .padding()
                    
                    //                    show section name:
                    ForEach(0..<checkListModel.checkListStructure.count, id: \.self){i in
                        if let section = checkListModel.checkListStructure[i].0{
                            
                            Text(section)
                                .foregroundColor(Color(.systemBlue))
                        }
                        
                        //                        show text field and check box:
                        HStack{
                         
                            ZStack{
//                               RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color(.systemBlue), lineWidth: 3 )
                                TextEditor(text: $checkListModel.checkListStructure[i].1)
//                                    .textFieldStyle(.roundedBorder)
//                                TextField("", text: $checkListModel.checkListStructure[i].1)
//                                    .opacity(1)
                                .multilineTextAlignment(.leading)
                                .lineLimit(5)
                                .font(.headline)
                                .foregroundColor(Color(.systemBlue))
                                .padding([.leading,.trailing, .top, .bottom], 5)
                                     
                                        .background(Color(.secondarySystemBackground))
                                        .cornerRadius(5.0)
                            }
                            .frame(minHeight: 40, alignment: .leading)
                            CheckBoxView(isChecked: $checkListModel.checkListStructure[i].2, title: "")
                        }.padding([.leading,.trailing], 20)
                    }
                
                    //                section naming alert:
                    .textFieldAlert(
                        isPresented: $isRenameAlertPresented,
                        title: "Enter section name",
                        text: "",
                        placeholder: "",
                        action: { newText in
                            let title = newText ?? ""
                            //                        adding new section to model:
                            checkListModel.checkListStructure.append((title, "", false))
                        }
                    )
                    
                    
                }
              
//                .navigationTitle("CHECK LIST")
//                .navigationBarTitleDisplayMode(.inline)
                
                
                //                file browse and load:
                .fileImporter(
                    isPresented: $isLoading,
                    allowedContentTypes: [.plainText],
                    allowsMultipleSelection: false
                ) { result in
                    do {
                        guard let selectedFile: URL = try result.get().first else { return }
                        //                        print(selectedFile)
                        if selectedFile.startAccessingSecurityScopedResource() {
                            guard let input = String(data: try Data(contentsOf: selectedFile), encoding: .utf8)
                            else { return }
                            //                            print("input=\(input)")
                            defer { selectedFile.stopAccessingSecurityScopedResource() }
                            let loadingText = input
                            //                            print(input)
                            let jsonDecoded = JSON(parseJSON: loadingText)
                            guard let array = jsonDecoded.array else {return}
                            //                            print("array:   \(array)")
                            //                            composing array for translation to model:
                            var loadedArray = [[String]]()
                            array.forEach{
                                //                                print("decoded element: \($0)")
                                let section = $0[0].rawValue as! String
                                let text = $0[1].rawValue as! String
                                let mark = $0[2].rawValue as! String
                                loadedArray.append([section, text, mark])
                            }
//                                checkListModel.reset()
                            //                            translation to model:
                            checkListModel.transformArrayAfterLoading(array: loadedArray)
                            
                        } else {
                            //                            handle denied access:
                            print("access denied...")
                        }
                    } catch {
                        //                        handle failure:
                        print("Unable to read file contents...")
                        print(error.localizedDescription)
                    }
                }
                
                
                
                
                    .toolbar{
                        //                    adding text field:
                        ToolbarItemGroup(placement: .navigationBarLeading){
                            Button(action: {
                                checkListModel.checkListStructure.append((nil, "", false))
                            },
                                   label: {Image(systemName: "plus.circle")
                                Text("field")})
                        }
                        //                    deleting text field:
                        ToolbarItemGroup(placement: .navigationBarLeading){
                            Button(action: {
                                if checkListModel.checkListStructure.count > 0 {
                                checkListModel.checkListStructure.removeLast()
                                }
                            }
                                   , label: {Image(systemName: "minus.circle")
                                Text("field")})
                        }
                        
                        //                    adding section:
                        ToolbarItemGroup(placement: .navigationBarTrailing){
                            Button(action: {
                                isRenameAlertPresented = true
                            },
                                   label: {Image(systemName: "plus.circle")
                                Text("section")})
                        }
                        

                        
                        ToolbarItemGroup(placement: .bottomBar){
                            
                            HStack{
                                
                                //                        saving file:
                                Button(action: {
                                    //                            transforming model to array for saving:
                                    let arrayForSaving = checkListModel.transformArrayForSaving()
                                    let json = JSON(arrayForSaving)
                                    let textToShare = json
                                    item = ActivityItem(items: "\(textToShare)")
                                }
                                       ,label: {Image(systemName: "tray.and.arrow.down")
                                    Text("Save")})
                                .activitySheet($item)
                                
                                
                                //                        activating trigger for browse and load file:
                                Button(action: {
                                    //                            checkListStructurecheckListModel.reset()
                                    self.isLoading = true
                                },
                                       label: {Image(systemName: "tray.and.arrow.up")
                                    Text("Load")})
                            }
                        }
                        
                        
                    }
            }

        }

//        to hide keyboard when scrolling:
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    
    public func textFieldAlert(
        isPresented: Binding<Bool>,
        title: String,
        text: String = "",
        placeholder: String = "",
        action: @escaping (String?) -> Void
    ) -> some View {
        self.modifier(TextFieldAlertModifier(isPresented: isPresented, title: title, text: text, placeholder: placeholder, action: action))
    }
    
}

