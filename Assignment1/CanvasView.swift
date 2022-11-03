//
//  CanvasView.swift
//  Assignment1
//
//  Created by HE Siyao on 2/11/2022.
//

import Foundation
import UIKit

// Long press on blank to change color
// double tap on blank to clear -> confirm. Completed
// single tap on a line : delete, red, yellow, blue, black. Completed
// Long press on a line and pan to move
// load existing image to canvas

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
    var selectedLineIndex: Int? {
        didSet{
            if selectedLineIndex == nil {
                UIMenuController.shared.hideMenu()
            }
        }
    }
    var vc : DrawViewController!
    
    // MARK: - Gesture Recognition
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        tapRecognizer.delaysTouchesBegan = true
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        
        
        tapRecognizer.require(toFail: doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        addGestureRecognizer(doubleTapRecognizer)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @objc func tap(_ gestureRecognizer: UIGestureRecognizer){
        let point = gestureRecognizer.location(in: self)
        selectedLineIndex = indexOfLine(at: point)
        let menu = UIMenuController.shared
        if selectedLineIndex != nil {
            becomeFirstResponder()
            // Menu Items
            let deleteItem = UIMenuItem(title: "Delete", action: #selector(deleteLine(_:)))
            let redItem = UIMenuItem(title: "Red", action: #selector(changeRed(_:)))
            let yellowItem = UIMenuItem(title: "Yellow", action: #selector(changeYellow(_:)))
            let blueItem = UIMenuItem(title: "Blue", action: #selector(changeBlue(_:)))
            let blackItem = UIMenuItem(title: "Black", action: #selector(changeBlack(_:)))
            var items = [deleteItem,redItem,yellowItem,blueItem,blackItem]
            
            switch currColor{
            case UIColor.red:
                items.remove(at: 1)
            case UIColor.yellow:
                items.remove(at: 2)
            case UIColor.blue:
                items.remove(at: 3)
            case UIColor.black:
                items.remove(at: 4)
            default: break
            }
            
            menu.menuItems = items
            let targetRect = CGRect(x: point.x, y: point.y, width: 2, height: 2)
            menu.showMenu(from: self, rect: targetRect)
                                        
        }else{
            menu.hideMenu()
        }
    }
    
    @objc func doubleTap(_ gestureRecognizer: UIGestureRecognizer){
        let alertController = UIAlertController(title: "Clear Canvas", message: "Are you sure?", preferredStyle: .alert)
        alertController.modalPresentationStyle = .automatic
        
        let confirmAction = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
            self.finishedLines.removeAll()
            self.currentLine = nil
            self.selectedLineIndex = nil
            self.setNeedsDisplay()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true)
        
        
    }
    // MARK: - Select a Line
    @objc func deleteLine(_ sender: UIMenuController){
        if let index = selectedLineIndex {
            finishedLines.remove(at: index)
            selectedLineIndex = nil
            setNeedsDisplay()
        }
    }
    
    @objc func changeRed(_ sender: UIMenuController){
        changeColorOneLine(color: UIColor.red)
    }
    @objc func changeYellow(_ sender: UIMenuController){
        changeColorOneLine(color: UIColor.yellow)
    }
    @objc func changeBlue(_ sender: UIMenuController){
        changeColorOneLine(color: UIColor.blue)
    }
    @objc func changeBlack(_ sender: UIMenuController){
        changeColorOneLine(color: UIColor.black)
    }
    
    func changeColorOneLine(color: UIColor){
        if let index = selectedLineIndex{
            finishedLines[index].color = color
            setNeedsDisplay()
        }
    }
    
    func indexOfLine(at point: CGPoint) -> Int? {
        for (index, line) in finishedLines.enumerated(){
            let begin = line.begin
            let end = line.end
            for t in stride(from: 0.0, to: 1.0, by: 0.05){
                let x = begin.x + ((end.x - begin.x)*t)
                let y = begin.y + ((end.y - begin.y)*t)
                if hypot(x - point.x, y - point.y) < 20 {
                    return index
                }
            }
        }
        return nil
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
