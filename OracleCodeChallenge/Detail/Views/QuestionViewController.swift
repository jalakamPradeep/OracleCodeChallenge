//
//  QuestionViewController.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import Foundation
import UIKit
import Combine

class QuestionViewController: UIViewController, UINavigationControllerDelegate {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: vars
    var questionItem: Item?
    var viewModel = HomeViewModel() //Init home view model
    var cancellable: AnyCancellable?
    var errorCancellable: AnyCancellable?
    
    // MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchData()
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
    
    func fetchData() {
        if let questionId = questionItem?.question_id {
            let baseUrlString = "https://api.stackexchange.com/2.2/questions/\(questionId)?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=10&filter=!9_bDDxJY5"
            viewModel.getHomeData(baseUrl: baseUrlString)
            configureData()
        }
    }
    
    func configureData() {
        // Subscribe to the view model to update the tableView
        activityIndicator.startAnimating()
        cancellable = viewModel.$items.sink(receiveValue:{
            [weak self] items in
            self?.activityIndicator.stopAnimating()
            self?.questionItem = items.first
            self?.tableView.reloadData()
        })
        
        // Helps handling error case if network fails
        errorCancellable = viewModel.$errorString.sink(receiveValue: {
            [weak self] errorString in
            if !errorString.isEmpty {
                let alert = UIAlertController(title: nil, message: errorString,         preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                
                self?.present(alert, animated: true, completion: nil)
                self?.activityIndicator.stopAnimating()
            }
        })
        
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
        if indexPath.row == 0, let questionItem = questionItem, let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionViewCell.self)) as? QuestionViewCell {
            cell.accessoryType = .none // as we are reusing the cell from main view we should remove accessory type(the arrow image)
            cell.cellConfigure(item: questionItem)
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionDescriptionCell.self)) as? QuestionDescriptionCell, let questionItem = questionItem {
                cell.cellConfigure(item: questionItem)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}



