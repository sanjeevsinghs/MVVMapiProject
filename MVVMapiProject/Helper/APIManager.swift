//
//  ApiManager.swift
//  MVVMapiProject
//
//  Created by bd01 on 30/12/25.
//

import Foundation

enum DataError: Error{
    case invalidResponce
    case invalidURL
    case invalidData
    case network(Error?)
}

//typealias Handler = (Result<[Product],  DataError>) -> Void
 // Singleton Design Pattern

typealias Handler<T> = (Result<T,  DataError>) -> Void

final class APIManager{
    
    static let shared = APIManager()
    private init() {}
    
    //generic
    
    func request<T: Decodable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ){
            guard let url = type.url else{
                completion(.failure(.invalidURL))
                return
            }
            
            //Back task complete fist using @escaping
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data, error == nil  else {
                    completion(.failure(.invalidData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      200 ... 299 ~= response.statusCode else{
                    completion(.failure(.invalidResponce))
                    return
                }
                
                do{
                    let products = try JSONDecoder().decode(modelType, from: data)
                    completion(.success(products))
                }catch{
                    completion(.failure(.network(error)))
                }
                
            }.resume()
    }
    
    
    
    
    // for not generic
    /*
    func  fetchProducts(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.productURL) else{
            completion(.failure(.invalidURL))
            return
        }
        
        //Back task complete fist using @escaping
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil  else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else{
                completion(.failure(.invalidResponce))
                return
            }
            
            do{
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            }catch{
                completion(.failure(.network(error)))
            }
            
        }.resume()
    }*/
}
