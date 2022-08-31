//
//  MachineView.swift
//  BMBTechSupport
//
//  Created by Vlad Kerov on 20.08.2022.
//

import SwiftUI

struct MachineView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var machineUpdateOperation: UpdateOperation<Machine>?
    
    @ObservedObject var machine: Machine
    
    @State var myMatricola = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
           Text("Machine:")
                .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                .font(.headline)
            makeMachineImage(machine: machine)
                .padding()
                HStack {
                    Text("Matricola:")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.headline)
                    Text("\(machine.matricola ?? "")")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.subheadline)
                }
                HStack {
                    Text("Customer:")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.headline)
                    Text("\(machine.customer ?? "")")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.subheadline)
                }
                HStack {
                    Text("Type of machine:")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.headline)
                    Text("\(machine.typeOfMachine ?? "")")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.subheadline)
                }
                HStack {
                    Text("Type of problem:")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.headline)
                    Text("\(machine.typeOfProblem ?? "")")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.subheadline)
                }
                HStack {
                    Text("Description of problem:")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.headline)
                    ScrollView{
                    Text("\(machine.descriptionOfProblem ?? "")")
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                            .font(.subheadline)
                }
                }
                HStack {
                    Text("Spare parts needed:")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.headline)
                    Text("\(machine.spareParts ?? "")")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.subheadline)
                }
                HStack {
                    Text("Status of machine:")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.headline)
                    Text("\(machine.statusOfMachine ?? "")")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                        .font(.subheadline)
                }
                
         
            
        }
        .padding(.top,10)
        .cornerRadius(10)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.blue, lineWidth: 5))
//        .onAppear{}
        .toolbar{
            Button("Update"){
                machineUpdateOperation = UpdateOperation(withExistingObject: machine, in: viewContext)
                
            }
        }
        .sheet(item: $machineUpdateOperation){ updateOperation in
            NavigationView{
                MachineEditorView(machine: updateOperation.childObject)
                    .navigationTitle("Update machine")
            }
            .environment(\.managedObjectContext, updateOperation.childContext)
            
        }
        Spacer()
    }
    
}



