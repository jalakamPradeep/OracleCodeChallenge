//
//  ViewController.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import UIKit
import Combine

class ViewController: UIViewController, UINavigationControllerDelegate {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Var
    var viewModel = HomeViewModel() //Init home view model
    var cancellable: AnyCancellable?
    var errorCancellable: AnyCancellable?
    var questionItems: [Item] = []
    var totalRows = 10 // useful to set Paging, represent how many items to pull
    
    // MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        //fetch data and updates view modal
        updateData()
    }
    
    // MARK: Support Functions
    
    func configureTableView() {
        // helps to tableview cell automatically adjust the size as per it's content
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        
        // register tableview cell
        tableView.register(UINib(nibName: String(describing: QuestionViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: QuestionViewCell.self))
    }
    
    func updateData() {
        viewModel.getHomeData(getItemCount: totalRows)
        configureData()
    }
    
    func configureData() {
        // Subscribe to the view model to update the tableView
        activityIndicator.startAnimating()
        cancellable = viewModel.$items.sink(receiveValue:{
            [weak self] items in
            self?.activityIndicator.stopAnimating()
            self?.questionItems = items
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
extension ViewController : UITableViewDataSource,  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionViewCell.self), for: indexPath) as? QuestionViewCell {
            cell.cellConfigure(item: questionItems[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    // push questionView controller on navigation stack with dependency injection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let questionViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: QuestionViewController.self)) as? QuestionViewController {
            questionViewController.questionItem = questionItems[indexPath.row]
            self.navigationController?.pushViewController(questionViewController, animated:true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == totalRows - 2 {
            totalRows += 10
            viewModel.getHomeData(getItemCount: totalRows)
        }
    }
    
}


