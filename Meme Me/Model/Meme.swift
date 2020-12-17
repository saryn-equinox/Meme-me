//
//  Meme.swift
//  Meme Me
//
//  Created by 邱浩庭 on 16/12/2020.
//

import Foundation
import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
    
    init(_ topText: String, _ bottomText: String, _ originalImage: UIImage, _ memeImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memeImage
    }
}
