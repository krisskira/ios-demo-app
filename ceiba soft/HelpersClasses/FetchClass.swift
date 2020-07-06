//
//  FetchClass.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 2/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import Foundation

class Fetch {
    
    enum Endpoints: String {
        case Users = "/users"
        case Post = "/posts?userId="
        func addQuerySting(parameter: String) -> String {
            self.rawValue + parameter
        }
    }
    
    fileprivate func buildUrl(endpoint: Endpoints, parameters: String) -> URL {
        let urlString = APIURL + endpoint.addQuerySting(parameter: parameters)
        return URL(string: urlString)!
    }
    
    func get(endpoint: Endpoints, parameters stringParameter: String = "", completion: @escaping (_ result: Result<Data,Error> ) -> Void ){
        
        let url = buildUrl(endpoint: endpoint, parameters: stringParameter)
        
        let task = URLSession.shared.dataTask(with: url ) {
            (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.sync {
                    completion( .failure( error ) )
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.sync {
                    completion( .failure( CustomError.build(errorString: .no_data) ) )
                }
                return
            }
            DispatchQueue.main.sync {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
