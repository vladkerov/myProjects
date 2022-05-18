//
//  ContentView.swift
//  IMMCalc
//
//  Created by Vlad Kerov on 18.01.2021.
//

import SwiftUI


struct ContentView: View {
    
    @State var isActive:Bool = false
    
    var body: some View {
        
        VStack {
            
            if self.isActive {
            
                MainView()
            
            } else {
                
                Image(systemName: "globe").resizable()
                    .foregroundColor(.blue)
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                
            }
            
        }.onAppear {
          
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
           
                withAnimation {
                    self.isActive = true
                }
            }
        
    }
    
    }
    
}





struct MainView: View {
    
    @State var screwType: Bool = false

    
    //    переменные, значения которых будут отслеживаться и передаваться на другую страницу
    
    @State private var selectedMaterial: Int = 0
    
    @State private var selectedScrew: Int = 0
    
    @State private var selectedTolshina: Int = 0
    
    @State private var vesIzdelia: String = ""
    
    @State private var kolichIzdelij: String = ""
    
    @State private var putTechenija: String = ""
    
    @State private var ploshad: String = ""
    
    let materialCount = materials.count
    
    
    var body: some View {
        
        NavigationView {

            
            Form{
                Picker(selection: $selectedMaterial, label: Text("Выберите материал изделия:"), content: {
                    ForEach(0..<materialCount, id: \.self){
                        Text(materials[$0])
                    }.id(materialCount)
         
                })
                
                VStack(alignment: .leading) {
                    Text("Введите вес одного изделия (гр):")
                    TextField("Значение от 1 до 5000", text: $vesIzdelia)
                    
                    Text("Введите количество изделий:")
                    TextField("Значение от 1 до 5000", text: $kolichIzdelij)
                }
                
                Picker(selection: $selectedTolshina, label: Text("Выберите толщину изделия:"), content: {
                    ForEach(0..<thickness.count, id: \.self){
                        Text(String(thickness[$0]))
                    }.id(thickness.count)
                })
                
                VStack(alignment: .leading) {
                    Text("Введите максимальный путь течения расплава изделия по стенке и дну (мм):")
                    TextField("Значение от 1 до 5000", text: $putTechenija)
                    
                    Text("Введите площадь проекции изделия на вертикальную плоскость (при горизонтальной установке ТПА) (см.кв.):")
                    TextField("Значение от 1 до 5000", text: $ploshad)
                    
                }
                Picker(selection: $selectedScrew, label: Text("Введите диаметр шнека (мм):"), content: {
                    ForEach(0..<screwDiameters.count, id: \.self){
                        Text(String(screwDiameters[$0]))
                    }.id(screwDiameters.count)
                })
                
                Toggle(isOn: $screwType) {
                    Text("OFF- трехзонный шнек, ON- барьерный шнек")
                }

                NavigationLink(destination: ResultView(selectedMaterial: self.$selectedMaterial, selectedScrew: self.$selectedScrew, selectedTolshina: self.$selectedTolshina,vesIzdelia: self.$vesIzdelia,kolichIzdelij: self.$kolichIzdelij,putTechenija: self.$putTechenija,ploshad: self.$ploshad, screwType: self.$screwType)){
                    Button(action: {
                        
                    }) {
                        Text("РАССЧИТАТЬ")
                    }
                }
                
                
                
                
            }
            .navigationTitle("Ввод параметров")
          
            
        }
        .cornerRadius(30)
   

       
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView()
                
            }
            
        }
    }
}
