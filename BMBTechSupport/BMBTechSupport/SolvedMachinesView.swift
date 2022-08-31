//
//  SolvedMachinesView.swift
//  BMBTechSupport
//
//  Created by Vlad Kerov on 23.08.2022.
//

import SwiftUI

struct SolvedMachinesView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Machine.matricola, ascending: true)], predicate: NSPredicate(format: "statusOfMachine = %@", "Solved"), animation: .default)

    private var machines: FetchedResults<Machine>
    var body: some View {
        VStack{
            Text("Solved cases:")
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
                }
                .onDelete(perform: deleteItems)
                .padding(.top, 3)   
            }
            .listStyle(.plain)
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


