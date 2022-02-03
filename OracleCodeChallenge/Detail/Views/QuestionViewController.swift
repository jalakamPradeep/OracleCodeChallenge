//
//  QuestionViewController.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController, UINavigationControllerDelegate {
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
        // we can reuse same cell created for  main view
        tableView.register(UINib(nibName: String(describing: QuestionViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: QuestionViewCell.self))
        tableView.register(UINib(nibName: String(describing: QuestionDescriptionCell.self), bundle: nil), forCellReuseIdentifier: String(describing: QuestionDescriptionCell.self))
    }
}



// MARK: Extensions
extension QuestionViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // can be done using in 2 rows by reusing main view tableviewcell
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // use if condition to check for row 1 as number of rows is fixed
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionViewCell.self)) as? QuestionViewCell {
            cell.accessoryType = .none // as we are reusing the cell from main view we should remove accessory type(the arrow image)
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionDescriptionCell.self)) as? QuestionDescriptionCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
}



