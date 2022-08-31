//
//  InProcessMachinesView.swift
//  BMBTechSupport
//
//  Created by Vlad Kerov on 23.08.2022.
//

import SwiftUI

struct InProcessMachinesView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.editMode) var editMode
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Machine.matricola, ascending: true)], predicate: NSPredicate(format: "statusOfMachine = %@", "In process"), animation: .default)

    private var machines: FetchedResults<Machine>
    
    var body: some View {
        VStack{
            Text("Cases in process:")
                .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                .font(.largeTitle)
            List {
                ForEach(machines) { machine in
                    HStack{
                        makeMachineImage(machine: machine)
                        NavigationLink {
                            MachineView(machine: machine)
                        } label: {
                            Text("Matricola: "+"\(machine.matricola ?? "")")
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.myCustomColor)
                                .font(.headline)
                        }
                    }
                    //                    .padding(.top, 30)
                }
//                .swipeActions()
//                .onMove(perform: {indexSet, index in
//                    $machines.move(fromOffsets: indexSet, toOffset: index)
//                })
                .onDelete(perform: deleteItems)
                .padding(.top, 3)
            }
            .listStyle(.plain)
//            .navigationTitle("In process")
            
        }
        
    }
    
    func deleteItems(offsets: IndexSet) {
        for index in offsets {
            let machine = machines[index]
            viewContext.delete(machine)
        }
        PersistenceController.shared.save()
    }
}




