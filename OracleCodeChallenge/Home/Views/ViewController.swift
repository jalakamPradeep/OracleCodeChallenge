//
//  ViewController.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: Support Functions
    
    func configureTableView() {
        // helps to tableview cell automatically adjust the size as per it's content
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        
        // register tableview cell
        tableView.register(UINib(nibName: String(describing: QuestionViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: QuestionViewCell.self))
    }
}



// MARK: Extensions
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionViewCell.self)) as? QuestionViewCell {
            return cell
        }
        
        return UITableViewCell()
    }
    
    // push questionView controller on navigation stack with dependency injection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let questionViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: QuestionViewController.self)) as? QuestionViewController {
            self.navigationController?.pushViewController(questionViewController, animated:true)
        }
        
    }
}



