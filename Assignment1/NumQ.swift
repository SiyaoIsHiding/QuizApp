//
//  NumQ.swift
//  Assignment1
//
//  Created by HE Siyao on 24/10/2022.
//

import Foundation

class NumQ: Codable{
    var question: String
    var answer: Float
    let date: Date
    let key: String
    var drawing: [Line]?
    
    init(_ question: String, _ answer: Float){
        self.question = question
        self.answer = answer
        self.date = Date()
        self.key = UUID().uuidString
    }
}
