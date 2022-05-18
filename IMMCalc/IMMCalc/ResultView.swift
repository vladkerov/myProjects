//
//  ResultView.swift
//  IMMCalc
//
//  Created by Vlad Kerov on 19.01.2021.
//

import SwiftUI


struct ResultView: View {
    
    
    //    все связанные с первой страницей переменные
    @Binding var selectedMaterial: Int
    
    @Binding var selectedScrew: Int
    
    @Binding  var selectedTolshina: Int
    
    @Binding  var vesIzdelia: String
    
    @Binding  var kolichIzdelij: String
    
    @Binding  var putTechenija: String
    
    @Binding  var ploshad: String
    
    @Binding var screwType: Bool
    
    //    инстанциализация модели с функциями расчетов
    let myModel = Model()
    
    var body: some View {
        
        
        //        let trimmedTolshina = tolshina.trimmingCharacters(in: .whitespaces)
        //        let floatTolshina = Float(trimmedTolshina) ?? 0
        //        if floatTolshina.isValidTolshina {
        //          Text("Теперь толщина-\(floatTolshina)")
        //        } else {
        //
        //            Text("Величина толщины вне пределов!")
        //
        //        }
        
        let trimmedVesIzdelia = vesIzdelia.trimmingCharacters(in: .whitespaces)
        let floatVesIzdelia = Float(trimmedVesIzdelia) ?? 0
        if floatVesIzdelia.isValidVes {
            //            Text("Теперь вес изделия-\(floatVesIzdelia)")
        } else {
            Text("Величина веса изделия вне пределов!")
        }
        
        let trimmedKolichIzdelij = kolichIzdelij.trimmingCharacters(in: .whitespaces)
        let floatKolichIzdelij = Float(trimmedKolichIzdelij) ?? 0
        if floatKolichIzdelij.isValidKolich {
            //            Text("Теперь количество изделий-\(floatKolichIzdelij)")
        } else {
            Text("Величина количества изделий вне пределов!")
        }
        
        let trimmedPutTechenija = putTechenija.trimmingCharacters(in: .whitespaces)
        let floatPutTechenija = Float(trimmedPutTechenija) ?? 0
        if floatPutTechenija.isValidPutTechenija {
            //            Text("Теперь путь течения-\(floatPutTechenija)")
        } else {
            Text("Величина пути течения вне пределов!")
        }
        
        let trimmedPloshad = ploshad.trimmingCharacters(in: .whitespaces)
        let floatPloshad = Float(trimmedPloshad) ?? 0
        if floatPloshad.isValidPloshad {
            //            Text("Теперь площадь-\(floatPloshad)")
        } else {
            Text("Величина площади вне пределов!")
        }
        
        
        if floatVesIzdelia.isValidVes&&floatKolichIzdelij.isValidKolich&&floatPutTechenija.isValidPutTechenija&&floatPloshad.isValidPloshad {
            
            
            
            
            let myDavlenieVnutriPF = myModel.davlenieVnutriPF(tolshina: thickness[selectedTolshina], dlinaTechenija: floatPutTechenija, materialIndex: selectedMaterial)
            
            
            let myDavlenieVpryska = myModel.davlenieVpryska(davlenievnutriPF: myDavlenieVnutriPF)
            
            
            let myDeltaDavlenija = myModel.deltaDavlenija(davlenievnutriPF: myDavlenieVnutriPF, davlenieVpryska: myDavlenieVpryska)
            
            
            
            
            let myDavlenieVyderzhki = myModel.davlenieVyderzhki(materialIndex: selectedMaterial, davlenieVpryska: myDavlenieVpryska)
            
            
            let myVremjaOhlazhdMin = myModel.vremjaOhlazhdMin(tolshina: Float(thickness[selectedTolshina]), materialIndex: selectedMaterial)
            
            let myVremjaOhlazhdMax = myModel.vremjaOhlazhdMax(tolshina: Float(thickness[selectedTolshina]), materialIndex: selectedMaterial)
            
            
            let massa = floatVesIzdelia*floatKolichIzdelij
            
            let myDozirObjem = myModel.dozirObyom(massa: massa, materialIndex: selectedMaterial)
            
            //            not shown:
            
            let myUsilieZazhima = myModel.usilieZazhima(davlenievnutriPF: myDavlenieVnutriPF, ploshad: floatPloshad)
            
            let myVremjaVyderzhkiMin = myModel.vremjaVyderzhki(materialIndex: selectedMaterial, vremjaOhl: myVremjaOhlazhdMin)
            
            let myVremjaVyderzhkiMax = myModel.vremjaVyderzhki(materialIndex: selectedMaterial, vremjaOhl: myVremjaOhlazhdMax)
            
            let myProtivodavlenie = myModel.protivodavlenie(tipShneka: screwType, materialIndex: selectedMaterial)
            
            let myHodDozir = myModel.hodDozir(massa: massa, materialIndex: selectedMaterial, radius: Float(screwDiameters[selectedScrew]/2))
            
            let mySkorVraschShneka = myModel.skorVraschShneka(materialIndex: selectedMaterial, diam: Float(screwDiameters[selectedScrew]))
            
            let myDekomprMin = myModel.dekomprMin(hodDozirovanija: myHodDozir)
            
            let myDekomprMax = myModel.dekomprMax(hodDozirovanija: myHodDozir)
            
            let myPodushka = myModel.podushka(materialIndex: selectedMaterial, diamShneka: Float(screwDiameters[selectedScrew]))
            
            
//            вывод данных на экран
            ScrollView{
            
                VStack(alignment: .leading){

                Text("Все входные данные корректны!").padding()
                    if let myPlotnost = Materials[selectedMaterial]["plotnost"] {
                        
                        let objem = (floatVesIzdelia*floatKolichIzdelij)/myPlotnost
                        
                        let myVremjaVpryska = myModel.vremjaVpryska(objem: objem, materialIndex: selectedMaterial, deltaDavlenija: myDeltaDavlenija)
                        
                        Text("Время впрыска(сек): \(myVremjaVpryska)")
                        Text(String(format: "%.2f",myVremjaVpryska))
                        
                    } else {
                            Text("Время впрыска не определено")
                        }
                
                    Text("Давление внутри ПФ(кг/см.кв): \(myDavlenieVnutriPF)")
                Text(String(format: "%.0f",myDavlenieVnutriPF))
                
                    Text("Давление впрыска(кг/см.кв): \(myDavlenieVpryska)")
                Text(String(format: "%.0f",myDavlenieVpryska))
                
                Text("Минимальное давление выдержки(кг/см.кв): \(myDavlenieVyderzhki.0)")
                Text(String(format: "%.0f",myDavlenieVyderzhki.0))
                
                VStack(alignment: .center){
                    Text("Максимальное давление выдержки(кг/см.кв): \(myDavlenieVyderzhki.1)")
                    Text(String(format: "%.0f",myDavlenieVyderzhki.1))

                    Text("Минимальное время охлаждения(сек): \(myVremjaOhlazhdMin)")
                    Text(String(format: "%.2f",myVremjaOhlazhdMin))

                    Text("Максимальное время охлаждения(сек): \(myVremjaOhlazhdMax)")
                    Text(String(format: "%.2f",myVremjaOhlazhdMax))

                    
                    //                let myVremjaOhlazhdMed = myModel.vremjaOhlazhdMed(tolshina: Float(thickness[selectedTolshina]), materialIndex: selectedMaterial)
                    //
                    //                Text("Среднее время охлаждения \(myVremjaOhlazhdMed)")
                    
                    
                    //
                    
                    
                }
                
            }
            
            VStack(alignment: .center){
     
                    Text("Мин. противодавление при дозировании(бар): - \(myProtivodavlenie.0)");
                Text(String(format: "%.0f",myProtivodavlenie.0))

                    Text("Макс. противодавление при дозировании(бар): - \(myProtivodavlenie.1)");
                Text(String(format: "%.0f",myProtivodavlenie.1))

                    Text("Объем дозы впрыска(см.куб):- \(myDozirObjem)")
                Text(String(format: "%.0f",myDozirObjem))

      
                    Text("Минимальное время выдержки(сек): \(myVremjaVyderzhkiMin)")
                Text(String(format: "%.2f",myVremjaVyderzhkiMin))

                    Text("Максимальное время выдержки(сек): \(myVremjaVyderzhkiMax)")
                Text(String(format: "%.2f",myVremjaVyderzhkiMax))

         
            }
        VStack(alignment: .center){

                    Text("Усилие зажима ПФ(кг):  - \(myUsilieZazhima)");
                Text(String(format: "%.0f",myUsilieZazhima))

                    Text("Ход дозирования(см):  - \(myHodDozir)");
                Text(String(format: "%.1f",myHodDozir))

                Text("Максимальная скорость вращения шнека(об/сек):  - \(mySkorVraschShneka)");
                Text(String(format: "%.0f",mySkorVraschShneka))

                    Text("Минимальная декомпрессия(мм):  - \(myDekomprMin)");
                Text(String(format: "%.1f",myDekomprMin))

                    Text("Максимальная декомпрессия(мм):  - \(myDekomprMax)");
                Text(String(format: "%.1f",myDekomprMax))
            }
            
            
    VStack(alignment: .center){
                    Text("Минимальная подушка(мм): - \(myPodushka.0)");
                    Text(String(format: "%.1f",myPodushka.0))

                    Text("Максимальная подушка(мм):  - \(myPodushka.1)");
                    Text(String(format: "%.1f",myPodushka.1))

                }

            }
            
            
        } else {
            Text("Присутствуют некорректные входные данные!")
            
        }
        
    }
}





struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(selectedMaterial: .constant(0), selectedScrew: .constant(0), selectedTolshina: .constant(0), vesIzdelia: .constant(""), kolichIzdelij: .constant(""), putTechenija: .constant(""), ploshad: .constant(""), screwType: .constant(false))
    }
}
