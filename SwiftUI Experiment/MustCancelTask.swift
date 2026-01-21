//
//  MustCancelTask.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/21/26.
//

import Foundation

struct DoSomethingTask {
    
    func userAction() {
        doSomething()
    }
    
    
    func doSomething() {
        
        print("Start task")
        
        let task = Task {
            for i in 1...10_000_000 {
                if Task.isCancelled { break }
                if i % 1000 == 0 {
                    print(i)
                }
            }
            
            print("End task")
        }
        
        print("Try cancel task")
        task.cancel()
    }

}

