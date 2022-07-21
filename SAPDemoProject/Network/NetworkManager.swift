//
//  NetworkManager.swift
//  SAPDemoProject
//
//  Created by Apple on 21/07/22.
//

import Foundation

enum ParseError: Error {
    case noData
    case dataDecodingError
}

struct NetworkManager {
    
    typealias ResultBlock<T> = (Result <T, ParseError>) -> Void
    
    //Parse json file into model
    func parseJsonFile<T: Decodable>(name: String, completion: @escaping ResultBlock<T>) {
        if let jsonData = self.readLocalFile(forName: name) {
            do {
                let decodedData: T = try JSONDecoder().decode(T.self, from: jsonData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.dataDecodingError))
            }
        } else {
            completion(.failure(.noData))
        }
    }
    
    //Read data from json file
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        }  catch {
            print(ParseError.noData)
        }
        
        return nil
    }
}
