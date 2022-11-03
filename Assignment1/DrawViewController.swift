//
//  DrawViewController.swift
//  Assignment1
//
//  Created by HE Siyao on 2/11/2022.
//

import Foundation
import UIKit

class DrawViewController: UIViewController{
    @IBOutlet var canvas: CanvasView!
    var numQ: NumQ!
    var imageStore: ImageStore!
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let image = canvas.snapshot()
        imageStore.setImage(image, forKey: numQ.key)
    }
    
}