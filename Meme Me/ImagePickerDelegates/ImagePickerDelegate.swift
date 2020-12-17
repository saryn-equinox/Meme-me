//
//  ImagePickerDelegate.swift
//  Meme Me
//
//  Created by 邱浩庭 on 16/12/2020.
//

import Foundation
import UIKit

class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var callerVC: NewMemeViewController!
    
    init(_ viewController: NewMemeViewController) {
        callerVC = viewController
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage {
            callerVC.imageView.image = img
            callerVC.bottomText.alpha = 1
            callerVC.topText.alpha = 1
            callerVC.shareButton.isEnabled = true
        }
        
        callerVC.dismiss(animated: true, completion: nil)
    }
    
//    func setCallerVC(_ viewController: NewMemeViewController) {
//        callerVC = viewController
//    }
}
