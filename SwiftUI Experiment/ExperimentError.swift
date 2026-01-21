//
//  ExperimentError.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/16/26.
//

import Foundation

enum ParseError: Error {
    case wrongDataType
    case keyNotFound
}

enum NetworkError: Error {
    case unreachable
}

class TestAPIManager {
    
    func handleParsingAndError() throws -> Int {
        do {
            let data = try JSONDecoder().decode(Int.self, from: Data())
            return data
        } catch is ParseError {
            throw ParseError.keyNotFound
        } catch is NetworkError {
            throw NetworkError.unreachable
        } catch {
            throw NSError(domain: "Generic error", code: -999)
        }
    }
}
