//
//  Model.swift
//  IMMCalc
//
//  Created by Vlad Kerov on 18.01.2021.
//

import Foundation




class Model {
    
    
    
    // вспомогательная функция
    func davlPFstep (davl2 p2: Float, davl1 p1: Float, put2 l2: Float, put1 l1: Float, put l: Float)-> Float {
        return (((l-l1)*(p2-p1)/(l2-l1))+p1)
    }
    
    // давление внутри ПФ
    // толщина в мм, длина течения в мм, площадь в кв.см
    // начало davlenieVnutriPF во время впрыска
    func davlenieVnutriPF (tolshina s : Double, dlinaTechenija l: Float, materialIndex i: Int)-> Float {
        
        let v = Float(Materials[i]["vjazkost"] ?? 0)
        
        let tuple = (v,s)
        
        var Pf: Double = 0
        
        switch tuple {
        
        case let (0,s) where s == 0.5 :
            let Pf = (l+6.85)/0.12
            return Pf
        case let (0,s) where s == 0.7 :
            let Pf = pow(M_E,(Double(l)+547.12)/103.63)
            return Float(Pf)
        case let (0,s) where s == 1.0 :
            let Pf = pow(M_E,(Double(l)+697.94)/141.6)
            return Float(Pf)
        case let (0,s) where s == 1.2 :
            let Pf = pow(M_E,(Double(l)+803.57)/169.96)
            return Float(Pf)
        case let (0,s) where s == 1.5 :
            let Pf = pow(M_E,(Double(l)+1048.94)/224.32)
            return Float(Pf)
        case let (0,s) where s == 2.0 :
            let Pf = pow(M_E,(Double(l)+1793.57)/383.77)
            return Float(Pf)
        case let (0,s) where s == 2.5 :
            
            if l<=200 {
                Pf = 175
                print ("length of flow is out of range!")
            } else if l>200 && l<=300 {
                Pf = Double(self.davlPFstep(davl2: 180, davl1: 175, put2: 300, put1: 200, put: l))
            } else if l>300 && l<=500 {
                Pf = Double(self.davlPFstep(davl2: 185, davl1: 180, put2: 500, put1: 300, put: l))
            } else if l>500 && l<=550 {
                Pf = Double(self.davlPFstep(davl2: 190, davl1: 185, put2: 550, put1: 500, put: l))
            } else if l>550 && l<=600 {
                Pf = Double(self.davlPFstep(davl2: 200, davl1: 190, put2: 600, put1: 550, put: l))
            } else if l>600 && l<=700 {
                Pf = Double(self.davlPFstep(davl2: 225, davl1: 200, put2: 700, put1: 600, put: l))
            } else if l>700 {
                Pf = 225
                print ("length of flow is out of range!")
            }
            return Float(Pf)
            
        case let (0,s) where s == 3.0 :
            
            if l<=200 {
                Pf = 170
                print ("length of flow is out of range!")
            } else if l>200 && l<=300 {
                Pf = Double(self.davlPFstep(davl2: 175, davl1: 170, put2: 300, put1: 200, put: l))
            } else if l>300 && l<=400 {
                Pf = Double(self.davlPFstep(davl2: 186, davl1: 175, put2: 400, put1: 300, put: l))
            } else if l>400 && l<=500 {
                Pf = Double(self.davlPFstep(davl2: 188, davl1: 186, put2: 500, put1: 400, put: l))
            } else if l>500 && l<=600 {
                Pf = Double(self.davlPFstep(davl2: 200, davl1: 188, put2: 600, put1: 500, put: l))
            } else if l>600 && l<=800 {
                Pf = Double(self.davlPFstep(davl2: 240, davl1: 200, put2: 800, put1: 600, put: l))
            } else if l>800 {
                Pf = 240
                print ("length of flow is out of range!")
            }
            return Float(Pf)
            
            
        case let (1,s) where s == 0.5 :
            let Pf = pow(M_E,(Double(l)+474.13)/79.42)
            return Float(Pf)
        case let (1,s) where s == 0.7 :
            let Pf = pow(M_E,(Double(l)+641.23)/111.83)
            return Float(Pf)
        case let (1,s) where s == 1.0 :
            let Pf = pow(M_E,(Double(l)+748.33)/140.27)
            return Float(Pf)
        case let (1,s) where s == 1.2 :
            let Pf = pow(M_E,(Double(l)+908.31)/175.51)
            return Float(Pf)
        case let (1,s) where s == 1.5 :
            let Pf = pow(M_E,(Double(l)+1070.58)/213.26)
            return Float(Pf)
        case let (1,s) where s == 2.0 :
            
            if l<=145 {
                Pf = 275
                print ("length of flow is out of range!")
            } else if l>145 && l<=200 {
                Pf = Double(self.davlPFstep(davl2: 280, davl1: 275, put2: 200, put1: 145, put: l))
            } else if l>200 && l<=250 {
                Pf = Double(self.davlPFstep(davl2: 300, davl1: 280, put2: 250, put1: 200, put: l))
            } else if l>250 && l<=300 {
                Pf = Double(self.davlPFstep(davl2: 350, davl1: 300, put2: 300, put1: 250, put: l))
            } else if l>300 && l<=350 {
                Pf = Double(self.davlPFstep(davl2: 400, davl1: 350, put2: 350, put1: 300, put: l))
            } else if l>350 && l<=400 {
                Pf = Double(self.davlPFstep(davl2: 450, davl1: 400, put2: 400, put1: 350, put: l))
            } else if l>400 {
                Pf = 450
                print ("length of flow is out of range!")
            }
            return Float(Pf)
            
        case let (1,s) where s == 2.5 :
            if l<=200 {
                Pf = 275
                print ("length of flow is out of range!")
            } else if l>200 && l<=300 {
                Pf = Double(self.davlPFstep(davl2: 280, davl1: 275, put2: 300, put1: 200, put: l))
            } else if l>300 && l<=375 {
                Pf = Double(self.davlPFstep(davl2: 300, davl1: 280, put2: 375, put1: 300, put: l))
            } else if l>375 && l<=460 {
                Pf = Double(self.davlPFstep(davl2: 350, davl1: 300, put2: 460, put1: 375, put: l))
            } else if l>460 && l<=540 {
                Pf = Double(self.davlPFstep(davl2: 400, davl1: 350, put2: 540, put1: 460, put: l))
            } else if l>540 && l<=600 {
                Pf = Double(self.davlPFstep(davl2: 450, davl1: 400, put2: 600, put1: 540, put: l))
            } else if l>600 {
                Pf = 450
                print ("length of flow is out of range!")
            }
            return Float(Pf)
            
        case let (1,s) where s == 3.0 :
            if l<=200 {
                Pf = 260
                print ("length of flow is out of range!")
            } else if l>200 && l<=300 {
                Pf = Double(self.davlPFstep(davl2: 265, davl1: 260, put2: 300, put1: 200, put: l))
            } else if l>300 && l<=400 {
                Pf = Double(self.davlPFstep(davl2: 270, davl1: 265, put2: 400, put1: 300, put: l))
            } else if l>400 && l<=500 {
                Pf = Double(self.davlPFstep(davl2: 275, davl1: 270, put2: 500, put1: 400, put: l))
            } else if l>500 && l<=600 {
                Pf = Double(self.davlPFstep(davl2: 300, davl1: 275, put2: 600, put1: 500, put: l))
            } else if l>600 && l<=700 {
                Pf = Double(self.davlPFstep(davl2: 325, davl1: 300, put2: 700, put1: 600, put: l))
            } else if l>700 && l<=770 {
                Pf = Double(self.davlPFstep(davl2: 350, davl1: 325, put2: 770, put1: 700, put: l))
            }   else if l>770 {
                Pf = 350
                print ("length of flow is out of range!")
            }
            return Float(Pf)
            
        case let (2,s) where s == 0.5 :
            let Pf = pow(M_E,(Double(l)+406.13)/66.62)
            return Float(Pf)
        case let (2,s) where s == 0.7 :
            let Pf = pow(M_E,(Double(l)+598.56)/101)
            return Float(Pf)
        case let (2,s) where s == 1.0 :
            let Pf = pow(M_E,(Double(l)+828.43)/146.49)
            return Float(Pf)
        case let (2,s) where s == 1.2 :
            let Pf = pow(M_E,(Double(l)+907.73)/168)
            return Float(Pf)
        case let (2,s) where s == 1.5 :
            let Pf = pow(M_E,(Double(l)+1171.8)/219.32)
            return Float(Pf)
        case let (2,s) where s == 2.0 :
            if l<=145 {
                Pf = 360
                print ("length of flow is out of range!")
            } else if l>145 && l<=200 {
                Pf = Double(self.davlPFstep(davl2: 370, davl1: 360, put2: 200, put1: 145, put: l))
            } else if l>200 && l<=250 {
                Pf = Double(self.davlPFstep(davl2: 400, davl1: 370, put2: 250, put1: 200, put: l))
            } else if l>250 && l<=290 {
                Pf = Double(self.davlPFstep(davl2: 450, davl1: 400, put2: 290, put1: 250, put: l))
            } else if l>290 && l<=325 {
                Pf = Double(self.davlPFstep(davl2: 500, davl1: 450, put2: 325, put1: 290, put: l))
            } else if l>325 && l<=400 {
                Pf = Double(self.davlPFstep(davl2: 600, davl1: 500, put2: 400, put1: 325, put: l))
            } else if l>400 && l<=450 {
                Pf = Double(self.davlPFstep(davl2: 700, davl1: 600, put2: 450, put1: 400, put: l))
            } else if l>450 && l<=490 {
                Pf = Double(self.davlPFstep(davl2: 750, davl1: 700, put2: 490, put1: 450, put: l))
            } else if l>490 {
                Pf = 750
                print ("length of flow is out of range!")
            }
            return Float(Pf)
            
        case let (2,s) where s == 2.5 :
            if l<=200 {
                Pf = 360
                print ("length of flow is out of range!")
            } else if l>200 && l<=300 {
                Pf = Double(self.davlPFstep(davl2: 375, davl1: 360, put2: 300, put1: 200, put: l))
            } else if l>300 && l<=390 {
                Pf = Double(self.davlPFstep(davl2: 400, davl1: 375, put2: 390, put1: 300, put: l))
            } else if l>390 && l<=450 {
                Pf = Double(self.davlPFstep(davl2: 450, davl1: 400, put2: 450, put1: 390, put: l))
            } else if l>450 && l<=500 {
                Pf = Double(self.davlPFstep(davl2: 500, davl1: 450, put2: 500, put1: 450, put: l))
            } else if l>500 && l<=600 {
                Pf = Double(self.davlPFstep(davl2: 600, davl1: 500, put2: 600, put1: 500, put: l))
            } else if l>600 {
                Pf = 600
                print ("length of flow is out of range!")
            }
            return Float(Pf)
            
        case let (2,s) where s == 3.0 :
            if l<=200 {
                Pf = 350
                print ("length of flow is out of range!")
            } else if l>200 && l<=400 {
                Pf = Double(self.davlPFstep(davl2: 360, davl1: 350, put2: 400, put1: 200, put: l))
            } else if l>400 && l<=520 {
                Pf = Double(self.davlPFstep(davl2: 375, davl1: 360, put2: 520, put1: 400, put: l))
            } else if l>520 && l<=600 {
                Pf = Double(self.davlPFstep(davl2: 400, davl1: 375, put2: 600, put1: 520, put: l))
            } else if l>600 && l<=780 {
                Pf = Double(self.davlPFstep(davl2: 450, davl1: 400, put2: 780, put1: 600, put: l))
            } else if l>780 && l<=810 {
                Pf = Double(self.davlPFstep(davl2: 500, davl1: 450, put2: 810, put1: 780, put: l))
            } else if l>810 {
                Pf = 500
                print ("length of flow is out of range!")
            }
            return Float(Pf)
            
            
            
        default:
            return 0
        }
        
        
    }
    
    // конец davlenieVnutriPF
    
    
//    усилие зажима ПФ
    func usilieZazhima (davlenievnutriPF d: Float, ploshad s: Float)-> Float{
        return (d*s*1.1)
    }
    
    //    давление впрыска
    func davlenieVpryska (davlenievnutriPF d: Float)-> Float {
        
        return ((0.0006*d*d)+(0.9375*d)+45.5856)
    }
    
    //    дельта давления впрыска и внутри пф
    func deltaDavlenija (davlenievnutriPF dpf: Float, davlenieVpryska dv: Float )-> Float {
        
        return(dv-dpf)
        
    }
    
    
    //    время впрыска  ????? (сомниительные результаты)
    func vremjaVpryska (objem v: Float, materialIndex i: Int, deltaDavlenija dp: Float )-> Float {
        
        let z = Float(Materials[i]["vjazkostRasplava"] ?? 0)
        let k = Float((Double.pi*1296)/(128*150))
        return ((v*z/(k*dp))*1000)
        
    }
    
    
    // давление выдержки мин и макс
    func davlenieVyderzhki (materialIndex i: Int, davlenieVpryska d: Float)-> (Float, Float) {
        
        let min = Float(Materials[i]["minDavlVyderzhki"] ?? 0)
        
        let max = Float(Materials[i]["maxDavlVyderzhki"] ?? 0)
        
        return (min*d, max*d)
        
    }
    
    
    //    время выдержки под давлением
    func vremjaVyderzhki (materialIndex i: Int, vremjaOhl t: Float)-> Float {
        
        return (fabsf(Float(Materials[i]["vremjaVyderzhki"] ?? 0)*t))
    }
    
    //    let materials = ["PP","PEHD","PELD","PS","ABS","SAN","PA6","PA66","POM","PC","PMMA","PPO","PBT","PET","PVC-hard","PVC-soft"]
    
    //    противодавление (в интерфейс надо добавить переключатель типа шнека трехзонный или барьерный)
    //0 - 3t screw, 1 - barrier
    func protivodavlenie (tipShneka t: Bool, materialIndex i: Int)-> (Float, Float) {

        let tuple = (i, t)
        
        var p: (Float, Float)
        
        switch  tuple {
        case (0, false):
            p = (50, 200)
            return p
        case (0, true):
            p = (30, 50)
            return p
        case (1, false):
            p = (50, 200)
            return p
        case (1, true):
            p = (30, 50)
            return p
        case (2, false):
            p = (50, 200)
            return p
        case (2, true):
            p = (30, 50)
            return p
        case (3, false):
            p = (50, 100)
            return p
        case (3, true):
            p = (30, 50)
            return p
        case (4, false):
            p = (50, 150)
            return p
        case (4, true):
            p = (30, 50)
            return p
        case (5, false):
            p = (50, 100)
            return p
        case (5, true):
            p = (30, 50)
            return p
        case (6, false):
            p = (20, 80)
            return p
        case (6, true):
            p = (20, 40)
            return p
        case (7, false):
            p = (20, 80)
            return p
        case (7, true):
            p = (20, 40)
            return p
        case (8, false):
            p = (50, 100)
            return p
        case (8, true):
            p = (30, 50)
            return p
        case (9, false):
            p = (100, 150)
            return p
        case (9, true):
            p = (40, 60)
            return p
        case (10, false):
            p = (100, 300)
            return p
        case (10, true):
            p = (40, 80)
            return p
        case (11, false):
            p = (30, 100)
            return p
        case (11, true):
            p = (30, 50)
            return p
        case (12, false):
            p = (50, 100)
            return p
        case (12, true):
            p = (30, 50)
            return p
        case (13, false):
            p = (50, 100)
            return p
        case (13, true):
            p = (30, 50)
            return p
        case (14, false):
            p = (50, 200)
            return p
        case (14, true):
            p = (30, 50)
            return p
        case (15, false):
            p = (50, 100)
            return p
        case (15, true):
            p = (30, 50)
            return p
            
            
        default:
            return (0, 0)
        }
        
    }
    
  
    // объем дозирования
    func dozirObyom ( massa m: Float, materialIndex i: Int)-> Float {
        let ro = Float(Materials[i]["plotnost"] ?? 1)
        return (m/ro)
    }
    
    //    ход дозирования
    func hodDozir (massa m: Float, materialIndex i: Int, radius r: Float)-> Float {
        let ro = Float(Materials[i]["plotnost"] ?? 0)
        return (((m/ro)/((Float.pi)*r*r/100))*1.225)
    }
    
    //    макс.скорость вращения шнека
    func skorVraschShneka (materialIndex i: Int, diam d: Float)-> Float {
        let vl = Float(Materials[i]["maxSkorostVrasch"] ?? 0)
        return ((vl/Float.pi*d)*10)
    }
    
    //    время охлаждения мин
    func vremjaOhlazhdMin (tolshina s: Float, materialIndex i: Int) -> Float {
        
        
        let tiMin = Float(Materials[i]["tIzvlechenijaMin"] ?? 0)
        let tfMin = Float(Materials[i]["tFormyMin"] ?? 0)
        
        let tlMin = Float(Materials[i]["tempRasplavamin"] ?? 0)
        
        let a = Float(Materials[i]["koeffTeploprovod"] ?? 0)
        
        
        let ti = tiMin
        let tf = tfMin
        let tl = tlMin
        
        return (fabsf((((s/2)*(s/2))*10/a)*(log10f(0.787*fabsf((ti-tf)/(tl-tf))))))
    }
    
    //    время охлаждения макс
    func vremjaOhlazhdMax (tolshina s: Float, materialIndex i: Int) -> Float {
        
        let tiMax = Float(Materials[i]["tIzvlechenijaMax"] ?? 0)
        
        
        let tfMax = Float(Materials[i]["tFormyMax"] ?? 0)
        
        let tlMax = Float(Materials[i]["tempRasplavamax"] ?? 0)
        let a = Float(Materials[i]["koeffTeploprovod"] ?? 0)
        
        let ti = tiMax
        let tf = tfMax
        let tl = tlMax
        
        
        return (fabsf((((s/2)*(s/2))*10/a)*(log10f(0.787*fabsf((ti-tf)/(tl-tf))))))
    }
    
//    время охлаждения сред
    func vremjaOhlazhdMed (tolshina s: Float, materialIndex i: Int) -> Float {
        
        let tiMed = Float(Materials[i]["tIzvlechenijaMin"] ?? 0)+(Float(Materials[i]["tIzvlechenijaMax"] ?? 0) - Float(Materials[i]["tIzvlechenijaMin"] ?? 0))/2
        
        
        let tfMed = Float(Materials[i]["tFormyMin"] ?? 0)+(Float(Materials[i]["tFormyMax"] ?? 0)-Float(Materials[i]["tFormyMin"] ?? 0))/2
        
        let tlMed = Float(Materials[i]["tempRasplavamin"] ?? 0)+(Float(Materials[i]["tempRasplavamax"] ?? 0)-(Float(Materials[i]["tempRasplavamin"] ?? 0))/2)
        let a = Float(Materials[i]["koeffTeploprovod"] ?? 0)
        
        let ti = tiMed
        let tf = tfMed
        let tl = tlMed
        
        
        return (fabsf((((s/2)*(s/2))*10/a)*(log10f(0.787*fabsf((ti-tf)/(tl-tf))))))
    }
    
    
    //    минимальный ход декомпресии
    func dekomprMin (hodDozirovanija s: Float)-> Float{
        return (s*0.05)
    }
    
    //    максимальный ход декомпресии
    func dekomprMax (hodDozirovanija s: Float)-> Float{
        return (s*0.1)
    }
    
    //    подушка материала
    func podushka(materialIndex i: Int, diamShneka d: Float)-> (Float, Float) {
        let c = Float(Materials[i]["termochuvstv"] ?? 1)
        
        let tuple = (d, c)
        
        var p: (Float, Float)
        
        switch  tuple {
        
        case (18, 1):
            p = (0.5, 1)
            return p
        case (18, 0):
            p = (1, 2)
            return p
        case (22, 1):
            p = (0.5, 1)
            return p
        case (22, 0):
            p = (1, 2)
            return p
        case (25, 1):
            p = (1, 1.5)
            return p
        case (25, 0):
            p = (2, 3)
            return p
        case (30, 1):
            p = (1.25, 2)
            return p
        case (30, 0):
            p = (2.5, 4)
            return p
        case (35, 1):
            p = (1.25, 2)
            return p
        case (35, 0):
            p = (2.5, 4)
            return p
        case (40, 1):
            p = (1.5, 2.5)
            return p
        case (40, 0):
            p = (3, 5)
            return p
        case (45, 1):
            p = (1.5, 2.5)
            return p
        case (45, 0):
            p = (3, 5)
            return p
        case (50, 1):
            p = (1.75, 3)
            return p
        case (50, 0):
            p = (3.5, 6)
            return p
        case (60, 1):
            p = (2, 3.5)
            return p
        case (60, 0):
            p = (4, 7)
            return p
        case (70, 1):
            p = (2, 3.5)
            return p
        case (70, 0):
            p = (4, 7)
            return p
        case (80, 1):
            p = (2.5, 5)
            return p
        case (80, 0):
            p = (5, 10)
            return p
        case (95, 1):
            p = (2.5, 5)
            return p
        case (95, 0):
            p = (5, 10)
            return p
        case (110, 1):
            p = (3.5, 6)
            return p
        case (110, 0):
            p = (7, 12)
            return p
        case (130, 1):
            p = (4, 7)
            return p
        case (130, 0):
            p = (7, 14)
            return p
        default:
            return (0, 0)
        }
        
        
        
        
        
    }
    
    
    
}


//трансформация текста в число
//let a:String = ""
//let b = a.trimmingCharacters(in: .whitespaces)
//let c = Float(b)


//валидация входных данных
extension Float {
    
    var isValidVes: Bool {
        if self.isLessThanOrEqualTo(100)&&self>0 {return true
            
            
        } else {
            print("Значение веса вне пределов")
            return false
        }
    }
}
extension Float {
    
    var isValidKolich: Bool {
        if self.isLessThanOrEqualTo(100)&&self>0 {return true
            
            
        } else {
            print("Значение количества вне пределов")
            return false
        }
    }
    
    
}

extension Float {
    
    var isValidTolshina: Bool {
        if self.isLessThanOrEqualTo(100)&&self>0 {return true
            
            
        } else {
            print("Значение толщины вне пределов")
            return false
        }
    }
}

extension Float {
    var isValidPutTechenija: Bool {
        if self.isLessThanOrEqualTo(1000)&&self>0 {return true
            
            
        } else {
            print("Значение пути течения вне пределов")
            return false
        }
    }
    
}

extension Float {
    var isValidPloshad: Bool {
        if self.isLessThanOrEqualTo(10000)&&self>0 {return true
            
            
        } else {
            print("Значение площади вне пределов")
            return false
        }
    }
}

