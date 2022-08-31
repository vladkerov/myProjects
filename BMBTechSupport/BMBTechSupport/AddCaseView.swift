//
//  AddCaseView.swift
//  BMBTechSupport
//
//  Created by Vlad Kerov on 18.08.2022.
//

import SwiftUI
//view for adding new case to data base
struct AddCaseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    private let typesOfMachine = ["Hybrid", "Electrical", "Hydraulical"]
    private let typesOfProblem = ["Mechanical", "Electrical", "Hydraulical"]
    private let statusesOfMachine = ["Solved", "In process", "Not started yet"]
    
    @FocusState var isFocused: Bool
    @State private var matricola: String = ""
    @State private var customer: String = ""
    @State private var typeOfMachine: String = ""
    @State private var typeOfProblem: String = ""
    @State private var descriptionOfProblem: String = ""
    @State private var spareParts: String = ""
    @State private var statusOfMachine: String = ""
    var body: some View {
        Form {
            Section {
                HStack{
                    Text("Matricola:")
                    TextField("", text: $matricola)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
//                        .overlay(alignment: .trailing, content: {
//                            Button("Check"){
//                                withAnimation(.easeInOut){
//                                    
//                                }
//                            }
//                            .font(.caption)
//                            .foregroundColor(.indigo)
//                            .opacity(0.5)
//                            .padding(.trailing, 15)
//                        })
                }
                ZStack(alignment: .leading){
                    Rectangle()
                        .fill(.black.opacity(0.2))
                    Rectangle()
                        .fill(.black)
                        .frame(width: isFocused ? nil : 0, alignment: .leading)
                        .animation(.easeInOut(duration: 0.3), value: isFocused)
                }
                .frame(height: 2)
            }
           
                HStack{
                    Text("Customer:")
                    TextField("", text: $customer)}
          
                HStack{
                    Text("Type of machine:")
                    Picker("", selection: $typeOfMachine){
                        ForEach(typesOfMachine, id: \.self) {
                            Text($0)
                        }
                    }
                }
          
                HStack{
                    Text("Type of problem:")
                    Picker("", selection: $typeOfProblem){
                        ForEach(typesOfProblem, id: \.self) {
                            Text($0)
                        }
                    }
                }
           
                HStack{
                    Text("Description of problem:")
                    TextField("", text: $descriptionOfProblem)}
          
                HStack{
                    Text("Spare parts:")
                    TextField("", text: $spareParts)}
         
                HStack{
                    Text("Status of machine:")
                    Picker("", selection: $statusOfMachine){
                        ForEach(statusesOfMachine, id: \.self) {
                            Text($0)
                        }
                    }
                }
        }
        .toolbar{
            ToolbarItem{
                Button(action: {
                    addCase(matricola: self.matricola, customer: self.customer, typeOfMachine: self.typeOfMachine, typeOfProblem: self.typeOfProblem, descriptionOfProblem: self.descriptionOfProblem, spareParts: self.spareParts, statusOfMachine: self.statusOfMachine)
                }, label: {
                    Text("Save machine")
                })
            }
        }  
    }
    private func addCase(matricola: String = "", customer: String = "", typeOfMachine: String = "", typeOfProblem: String = "", descriptionOfProblem: String = "", spareParts: String = "", statusOfMachine: String = "" ) {
        withAnimation {
            let newCase = Machine(context: viewContext)
            newCase.id = UUID()
            newCase.matricola = matricola
            newCase.customer = customer
            newCase.typeOfMachine = typeOfMachine
            newCase.typeOfProblem = typeOfProblem
            newCase.descriptionOfProblem = descriptionOfProblem
            newCase.spareParts = spareParts
            newCase.statusOfMachine = statusOfMachine
            
            do {
                try viewContext.save()
                dismiss()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

