//
//  MachineEditorView.swift
//  BMBTechSupport
//
//  Created by Vlad Kerov on 20.08.2022.
//

import SwiftUI

struct MachineEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var childContext
    
    @ObservedObject var machine: Machine
    
    private let typesOfMachine = ["Hybrid", "Electrical", "Hydraulical"]
    private let typesOfProblem = ["Mechanical", "Electrical", "Hydraulical"]
    private let statusesOfMachine = ["Solved", "In process", "Not started yet"]

    var body: some View {
        Form {
            Section(header: Text("Editing of info")) {
                if let matricola = Binding($machine.matricola) {
                    HStack {
                        Text("Matricola is:")
                        TextField("Input matricola:", text: matricola)
                    }
                }
                if let customer = Binding($machine.customer) {
                    HStack {
                        Text("Customer is:")
                        TextField("Input customer:", text: customer)
                    }
                }
                if let typeOfMachine = Binding($machine.typeOfMachine) {
                    //                        Text("Type of machine is:")
                    Picker("Input type of machine:", selection: typeOfMachine){
                        ForEach(typesOfMachine, id: \.self) {
                            Text($0)
                        }
                    }
                }
                if let typeOfProblem = Binding($machine.typeOfProblem) {
                    //                        Text("Type of problem is:")
                    Picker("Input type of problem:", selection: typeOfProblem){
                        ForEach(typesOfProblem, id: \.self) {
                            Text($0)
                        }
                    }
                }
                if let descriptionOfProblem = Binding($machine.descriptionOfProblem) {
                    HStack {
                        Text("Description of problem is:")
                        TextField("Input description of problem:", text: descriptionOfProblem)
                    }
                }
                if let spareParts = Binding($machine.spareParts) {
                    HStack {
                        Text("Spare parts are:")
                        TextField("Input spare parts:", text: spareParts)
                    }
                }
                if let statusOfMachine = Binding($machine.statusOfMachine) {
                    //                        Text("Status of machine is:")
                    Picker("Input status of machine:", selection: statusOfMachine){
                        ForEach(statusesOfMachine, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
            }
            
            
        }
        .toolbar {
            Button() {
                try? childContext.save()
                dismiss()
            } label: {
                Text("Save")
            }
        }
    }
}



