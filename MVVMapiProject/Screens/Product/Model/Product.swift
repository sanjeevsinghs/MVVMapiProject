//
//  Product.swift
//  MVVMapiProject
//
//  Created by bd01 on 30/12/25.
//

import Foundation

struct Product: Decodable{
    let id:Int
    let title:String
    let price:Double
    let description:String
    let category:String
    let image:String
    let rating:rate
}

struct rate: Decodable{
    let rate:Double
    let count:Int
}
