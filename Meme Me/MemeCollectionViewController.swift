//
//  MemeCollectionViewController.swift
//  Meme Me
//
//  Created by 邱浩庭 on 16/12/2020.
//

import UIKit

class MemeCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    private let memeCollectionViewDelege = MemeCollectionViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = memeCollectionViewDelege
        collectionView.dataSource = memeCollectionViewDelege
        let space: CGFloat = 3.0
        let widthDiemension = (view.frame.size.width - 2 * space) / 3.0
        let heightDiemension = (view.frame.size.height - 2 * space) / 3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDiemension, height: heightDiemension)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    @IBAction func addNewMeme(_ sender: Any) {
        let newMemeVC = self.storyboard?.instantiateViewController(identifier: "NewMemeView Controller") as! NewMemeViewController
        present(newMemeVC, animated: true, completion: nil)
    }
    
    @objc private func reload() {
        collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
