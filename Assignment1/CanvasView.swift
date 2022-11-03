//
//  CanvasView.swift
//  Assignment1
//
//  Created by HE Siyao on 2/11/2022.
//

import Foundation
import UIKit

class CanvasView: UIView{
    
    // MARK: Attributes
    struct Line{
        var begin = CGPoint.zero
        var end = CGPoint.zero
        var color = UIColor.black
    }
    var currentLine : Line?
    var finishedLines = [Line]()
    var currColor = UIColor.black
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Render
    func stroke(_ line: Line){
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = .round
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect){
        for line in finishedLines{
            line.color.setStroke()
            stroke(line)
        }
        
        if let current = currentLine{
            current.color.setStroke()
            stroke(current)
        }
         
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let newLine = Line(begin: location, end: location, color: currColor)
        currentLine = newLine
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        currentLine?.end = touch.location(in: self)
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if var line = currentLine{
            let touch = touches.first!
            line.end = touch.location(in: self)
            finishedLines.append(line)
            currentLine = nil
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentLine = nil
        setNeedsDisplay()
    }
    
    // MARK: - Image Saving and Loading
    func snapshot() -> UIImage{
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

}
