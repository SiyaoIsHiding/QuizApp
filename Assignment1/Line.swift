//
//  Line.swift
//  Assignment1
//
//  Created by HE Siyao on 3/11/2022.
//

import Foundation
import UIKit


struct Line: Codable{
    var begin = CGPoint.zero
    var end = CGPoint.zero
    var color = UIColor.black
    
    enum CodingKeys: String, CodingKey{
        case begin
        case end
        case color
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(begin, forKey: .begin)
        try container.encode(end, forKey: .end)
        switch color{
        case UIColor.red:
            try container.encode("red", forKey: .color)
        case UIColor.yellow:
            try container.encode("yellow", forKey: .color)
        case UIColor.blue:
            try container.encode("blue", forKey: .color)
        case UIColor.black:
            try container.encode("black", forKey: .color)
        default: break
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        begin = try container.decode(CGPoint.self, forKey: .begin)
        end = try container.decode(CGPoint.self, forKey: .end)
        let colorString = try container.decode(String.self, forKey: .color)
        switch colorString{
        case "red":
            color = UIColor.red
        case "yellow":
            color = UIColor.yellow
        case "blue":
            color = UIColor.blue
        case "black":
            color = UIColor.black
        default: break
        }
    }
    
    init(begin: CGPoint, end: CGPoint, color: UIColor){
        self.begin = begin
        self.end = end
        self.color = color
    }
    
}
