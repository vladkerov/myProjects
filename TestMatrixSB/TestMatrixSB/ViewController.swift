//
//  ViewController.swift
//  TestMatrixSB
//
//  Created by Vlad Kerov on 11.03.2021.
//

import UIKit

class ViewController: UIViewController {
    let matrix1 = [[1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10]]
    
    let matrix2 = [[1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10],
                   [1,2,3,4,5,6,7,8,9,10]]
    
    
    var resultMatrix = [[0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0]]
    
    
    let safeQueue = DispatchQueue(label: "com.safequeue", attributes: .concurrent)
    
    func matrixMultiply (matrix1:[[Int]], matrix2:[[Int]])-> [[Int]]  {
        let n = matrix1[0].count
        let m = matrix1.count
        let q = matrix2[0].count
        
        
        
        DispatchQueue.concurrentPerform(iterations: m){ (i) in

            print("цикл i:\(i)",Thread.current)
            
            DispatchQueue.concurrentPerform(iterations: q){ (j) in

                print("цикл j:\(j)",Thread.current)
                var result = 0
                DispatchQueue.concurrentPerform(iterations: n){ (k) in

                    print("цикл k:\(k), i =\(i), j = \(j)",Thread.current)
                    result += (matrix1[i][k])*(matrix2[k][j])
                }
                safeQueue.sync(flags: .barrier){
                    print("запись значения в результирующую матрицу:\(i),\(j)",Thread.current)
                self.resultMatrix[i][j] = result
                }
            }
        }
        return resultMatrix
    }
    override func viewDidLoad() {
        let newMatrix = matrixMultiply(matrix1: matrix1, matrix2: matrix2)
        print(newMatrix)
        super.viewDidLoad()
    }
}

