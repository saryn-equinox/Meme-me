//
//  MemeTableViewDelegate.swift
//  Meme Me
//
//  Created by 邱浩庭 on 16/12/2020.
//

import Foundation
import UIKit

/**
 (1) How many items to show
 (2) Value for each cell
 */
class MemeTableViewDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var callerVC: MemeTableViewController!
    
    init(_ viewController: MemeTableViewController) {
        callerVC = viewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let memes = (UIApplication.shared.delegate as! AppDelegate).memes
//        print(memes.count)
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = (UIApplication.shared.delegate as! AppDelegate).memes[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell")!
        cell.textLabel!.text = meme.topText + "..." + meme.bottomText
        cell.imageView!.image = meme.memedImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = callerVC.storyboard?.instantiateViewController(identifier: "detailViewController") as! DetailViewController
        detailVC.imageToShow = (UIApplication.shared.delegate as! AppDelegate).memes[(indexPath as NSIndexPath).row].memedImage
        callerVC.navigationController?.pushViewController(detailVC, animated: true)
    }
}
