//
//  NumQStore.swift
//  Assignment1
//
//  Created by HE Siyao on 24/10/2022.
//

class NumQStore{
    static var allNumQ: [NumQ] = [NumQ( "3+3=", 6), NumQ("3**3=", 27), NumQ("9/2=", 4.5)]

    static func createNumQ(numq: NumQ){
        allNumQ.append(numq)
    }
    
    static func removeNumQ(ind: Int){
        allNumQ.remove(at: ind)
    }
    
    static func moveNumQ(from: Int, to: Int){
        let temp = allNumQ[from]
        allNumQ.remove(at: from)
        allNumQ.insert(temp, at: to)
    }
    

}
