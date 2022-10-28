//
//  NumQStore.swift
//  Assignment1
//
//  Created by HE Siyao on 24/10/2022.
//

import Foundation
import UIKit

class NumQStore{
    static var vc: FillInBlankViewController?
    static var allNumQ: [NumQ] = {
        do {
            let notification = NotificationCenter.default
            notification.addObserver(NumQStore.self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
            let data = try Data(contentsOf: dataURL)
            let decoder = PropertyListDecoder()
            let numqs = try decoder.decode([NumQ].self, from: data)
            print("data loaded")
            return numqs
        }catch{
            print("fail to load data")
            return []
        }
    }()
    
    static let dataURL : URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("NumQs.plist")
    }()
    
    
  
    static var numQScore: [Int] = []
    static var mcqScore: [Int] = [0,0,0]

    @objc static func saveChanges() -> Bool {
        print(dataURL)
        do{
            let coder = PropertyListEncoder()
            let data = try coder.encode(allNumQ)
            try data.write(to: dataURL, options: .atomic)
            return true
        }catch{
            print("Save data error: \(error)")
        }
        return false
    }
    
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
