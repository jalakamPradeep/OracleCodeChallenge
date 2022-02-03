//
//  ViewController.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import UIKit
import Combine

final class ViewController: UIViewController, UINavigationControllerDelegate {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: Var
    private var viewModel = HomeViewModel() //Init home view model
    private var cancellable: AnyCancellable?
    private var errorCancellable: AnyCancellable?
    private var questionItems: [Item] = []
    fileprivate var totalRows = 10 // useful to set Paging, represent how many items to pull
    private let refreshControl = UIRefreshControl()
    
    // MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        //fetch data and updates view modal
        fetchData()
        subscribeToData()
    }
    
    // MARK: Support Functions
    
    private func configureTableView() {
        // helps to tableview cell automatically adjust the size as per it's content
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        // register tableview cell
        tableView.register(UINib(nibName: String(describing: QuestionViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: QuestionViewCell.self))
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Weather Data
        fetchData()
    }
    fileprivate func fetchData() {
        activityIndicator.startAnimating()
        let baseUrlString = "https://api.stackexchange.com/2.2/questions?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize="+"\(totalRows)"
        viewModel.getHomeData(baseUrl: baseUrlString)
    }
    
    private func subscribeToData() {
        // Subscribe to the view model to update the tableView
        cancellable = viewModel.$items.sink(receiveValue:{
            [weak self] items in
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.stopAnimating()
            self?.questionItems = items
            self?.tableView.reloadData()
        })
        
        // Helps handling error case if network fails
        errorCancellable = viewModel.$errorString.sink(receiveValue: {
            [weak self] errorString in
            if !errorString.isEmpty {
                self?.refreshControl.endRefreshing()
                self?.activityIndicator.stopAnimating()
                let alert = UIAlertController(title: nil, message: errorString,         preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                
                self?.present(alert, animated: true, completion: nil)
                
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
            // we can use most of the modal from top questions instead of pulling every thing, so dependency injecting question item
            questionViewController.questionItem = questionItems[indexPath.row]
            self.navigationController?.pushViewController(questionViewController, animated:true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == totalRows - 2 {
            totalRows += 10
            self.fetchData()
        }
    }
    
}


