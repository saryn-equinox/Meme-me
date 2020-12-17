//
//  MemeTableViewController.swift
//  Meme Me
//
//  Created by 邱浩庭 on 16/12/2020.
//

import UIKit

class MemeTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var tableViewDelegate: MemeTableViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDelegate = MemeTableViewDelegate(self)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDelegate
        self.modalPresentationStyle = .fullScreen
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addNewMeme(_ sender: Any) {
        let newMemeVC = self.storyboard?.instantiateViewController(identifier: "NewMemeView Controller") as! NewMemeViewController
        present(newMemeVC, animated: true, completion: nil)
    }
    
    @objc private func reload() {
        tableView.reloadData()
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
