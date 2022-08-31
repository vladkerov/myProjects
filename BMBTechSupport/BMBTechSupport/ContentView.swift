//
//  ContentView.swift
//  BMBTechSupport
//
//  Created by Vlad Kerov on 14.08.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    //    MARK: making fetch request for all machines in local data base
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Machine.matricola, ascending: true)], animation: .default)
    
    private var machines: FetchedResults<Machine>
    
    @State private var machineCreateOperation: CreateOperation<Machine>?
    
    var body: some View {
        NavigationView {
            TabView(){
                InProcessMachinesView()
                    .tag(1)
                    .padding(.top, 5)
                
                    .tabItem {
                        Label("In process", systemImage: "hand.raised.fill")
                    }
                NotStartedYetMachinesView()
                    .tag(2)
                    .padding(.top, 5)
                    .tabItem {
                        Label("Not started", systemImage: "hand.thumbsdown.fill")
                    }
                SolvedMachinesView()
                    .tag(3)
                    .padding(.top, 5)
                    .tabItem {
                        Label("Solved", systemImage: "hand.thumbsup.fill")
                    }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                    //                        .background(RoundedRectangle(cornerRadius: 5, style: .continuous)
                    //                            .fill(.blue.opacity(0.05)))
                }
                ToolbarItem {
                    NavigationLink(destination:    AddCaseView(), label:{
                        Text("Add machine")
                        //                            .background(RoundedRectangle(cornerRadius: 5, style: .continuous)
                        //                                .fill(.blue.opacity(0.05)))
                    })
                }
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink(destination: EULAView(), label: {
                        Image(systemName: "questionmark.circle")
                    })
                }
            }
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

func makeMachineImage(machine: Machine) -> some View{
    var frameColor: Color
    var typeImage: Image
    switch machine.statusOfMachine{
    case "Solved": frameColor = Color.green
    case "Not started yet": frameColor = Color.red
    case "In process": frameColor = Color.yellow
    case .none: frameColor = Color.white
    case .some(_): frameColor = Color.black
    }
    
    switch machine.typeOfMachine{
    case "Hydraulical": typeImage = Image("KW 1150-12500")
    case "Electrical": typeImage = Image("eKW45Pi-5500_Full_Electric")
    case "Hybrid": typeImage = Image("eKW45Pi-5500_Full_Electric")
    case .none: typeImage = Image("KW 1150-12500")
    case .some(_): typeImage = Image("KW 1150-12500")
    }
    return typeImage
        .resizable()
        .aspectRatio(contentMode: .fit)
        . frame(width: 100, height: 100, alignment: .center)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(frameColor, lineWidth: 5))
    //                .shadow(radius: 10)
    //        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    //        .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
    //        .border(frameColor, width: 10)
    //        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
}


extension UIApplication {
    func closeKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Color{
    public static var myCustomColor: Color {
        return Color(UIColor(red: 0/255, green: 25/255, blue: 150/255, alpha: 1.0))
    }
}

struct customColorModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.init(.sRGB, red: 0, green: 0.1, blue: 0.6, opacity: 1))
    }
}


