//
//  InputService.swift
//  SquareTest
//
//  Created by Srivalli Kanchibotla on 6/5/23.
//

import Foundation

class InputService {
    
    var inputURL = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    
    func getEmployeeData() async throws -> Employees {
        guard let url = URL(string: inputURL) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(Employees.self, from: data)
    }
    
}


