//
//  MemeCollectionViewDelegate.swift
//  Meme Me
//
//  Created by 邱浩庭 on 16/12/2020.
//

import Foundation
import UIKit

class MemeCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var callerVC: MemeCollectionViewController!
    
    init(_ viewController: MemeCollectionViewController) {
        callerVC = viewController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = (UIApplication.shared.delegate as! AppDelegate).memes[(indexPath as NSIndexPath).row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as! MemeCollectionViewCell
        cell.imageView.image = meme.memedImage
        cell.imageView.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = callerVC.storyboard?.instantiateViewController(identifier: "detailViewController") as! DetailViewController
        detailVC.imageToShow = (UIApplication.shared.delegate as! AppDelegate).memes[(indexPath as NSIndexPath).row].memedImage
        callerVC.navigationController?.pushViewController(detailVC, animated: true)
    }
}
