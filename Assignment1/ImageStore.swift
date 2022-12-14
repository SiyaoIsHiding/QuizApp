//
//  ImageStore.swift
//  Assignment1
//
//  Created by HE Siyao on 31/10/2022.
//

import Foundation
import UIKit

class ImageStore{
    let cache = NSCache<NSString, UIImage>()
    
    func imageURL(forKey key: String) -> URL{
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
    func setImage(_ image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as NSString)
        let url = imageURL(forKey: key)
        if let data = image.jpegData(compressionQuality: 0.5) {
            try? data.write(to: url)
            print(url)
        }
    }
    
    func image(forKey key: String) -> UIImage?{
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func removeImage(forKey key: String){
        cache.removeObject(forKey: key as NSString)
        let url = imageURL(forKey: key)
        do{
            try FileManager.default.removeItem(at: url)
        }catch{
            print("No image to delete")
        }
    }
    
}
