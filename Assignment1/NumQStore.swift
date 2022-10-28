//
//  NumQStore.swift
//  Assignment1
//
//  Created by HE Siyao on 24/10/2022.
//

class NumQStore{
    static var vc: FillInBlankViewController?
    static var allNumQ: [NumQ] = []
    static var numQScore: [Int] = []
    static var mcqScore: [Int] = [0,0,0]

    static func refreshMcq(){
        mcqScore = Array(repeating: 0, count: 3)
    }
    
    static func refreshNumQ(){
        if let vc = vc {
            vc.viewDidLoad()
        }
        numQScore = Array(repeating: 0, count: allNumQ.count)
    }
    static func createNumQ(numq: NumQ){
        allNumQ.append(numq)
        refreshNumQ()
    }
    
    static func removeNumQ(ind: Int){
        allNumQ.remove(at: ind)
        refreshNumQ()
    }
    
    static func moveNumQ(from: Int, to: Int){
        let temp = allNumQ[from]
        allNumQ.remove(at: from)
        allNumQ.insert(temp, at: to)
        refreshNumQ()
    }
    

}
