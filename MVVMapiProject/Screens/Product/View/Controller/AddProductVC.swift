//
//  AddProductVC.swift
//  MVVMapiProject
//
//  Created by bd01 on 02/01/26.
//

import UIKit

struct AddProduct: Encodable {
    let title: String
}

struct ProductResponse: Decodable {
    let id: Int
    let title: String
}

class AddProductVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    addProduct()
        // Do any additional setup after loading the view.
    }
    
    func addProduct(){
        guard let url = URL(string: "https://dummyjson.com/products/add") else { return }
        
        let parameters = AddProduct(title: "BMW car")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(parameters)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { data, responcse, error in
            guard let data else { return }
            do {
                let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                print(productResponse)
            }catch{
                print(error)
            }
        }.resume()
    }
    

}
