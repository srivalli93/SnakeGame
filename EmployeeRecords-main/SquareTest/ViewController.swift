//
//  ViewController.swift
//  SquareTest
//
//  Created by Srivalli Kanchibotla on 6/5/23.
//

import UIKit
import SkeletonView

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableview = UITableView()
    var employeeData : [Employee] = []
    
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEmployeeData()
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableview)
        tableview.register(EmployeeCellTableViewCell.self, forCellReuseIdentifier: "employeeCell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .singleLine
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100
        tableview.isSkeletonable = true
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        //adding refreshControl
        tableview.refreshControl = UIRefreshControl()
        tableview.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing data ...")
        tableview.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
    }
    
    func loadEmployeeData() {
        
        Task {
            do {
                let employees = try await InputService().getEmployeeData()
                self.employeeData = employees.employees
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.tableview.hideSkeleton()
                }
                
            } catch {
                let errorAlert = UIAlertController(title: "Error", message: "Something went wrong. Please try again later or refresh the page", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(errorAlert, animated: true)
            }
        }
        
//        InputService().getEmployeeData()
//        
//        InputService().getEmployeeData { [weak self] result in
//            switch result {
//            case .success(let results):
//                self?.employeeData = results.employees
//                DispatchQueue.main.async {
//                    self?.tableview.reloadData()
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                    self?.tableview.hideSkeleton()
//                }
//                
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    let errorAlert = UIAlertController(title: "Error", message: "Something went wrong. Please try again later or refresh the page", preferredStyle: .alert)
//                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
//                    self?.present(errorAlert, animated: true)
//                }
//                print(error)
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        header.backgroundColor = UIColor(named: "headerColor")
        
        let sortButton = UIButton(type: .system)
        sortButton.setTitle("Sort", for: .normal)
        sortButton.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        header.addSubview(sortButton)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.topAnchor.constraint(equalTo: header.topAnchor, constant: 10).isActive = true
        sortButton.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -20).isActive = true
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if employeeData.count == 0 {
            tableView.emptyTableView(titleText: "There are no Employee List", messageText: "The employee list will be here")
        } else {
            tableView.restoreTableView()
        }
        return employeeData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "employeeCell") as! EmployeeCellTableViewCell

        let currentData = employeeData[indexPath.row]
        cell.employeeCellTitle.text = currentData.full_name
        cell.employeeCellSubTitle.text = currentData.team
        cell.employeeCellDescription.text = currentData.biography ?? ""
        
        if let imageURL = currentData.photo_url_small {
            self.loadImage(imageURL) { result in
                switch result {
                case .success(let image):
                    cell.employeeImage.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //fade animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.isSkeletonable = true
        cell.showAnimatedGradientSkeleton()
        UIView.animate(withDuration: 0.6, delay: 0.04 * Double(indexPath.row)) {
            cell.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            cell.hideSkeleton()
        }
    }
    
    func loadImage(_ inputUrl: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: inputUrl) else {
            return
        }
        if let image = imageCache.object(forKey: inputUrl as NSString) {
            completionHandler(.success(image))
        }
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { data, res, err in
                if let data = data {
                    DispatchQueue.main.async { [self] in
                        let image = UIImage(data: data)
                        self.imageCache.setObject(image!, forKey: inputUrl as NSString)
                        completionHandler(.success(UIImage(data: data)!))
                    }
                        
                } else {
                    completionHandler(.failure(err!))
                }
            }.resume()
            
        }
    }
    
    @objc func sortButtonTapped() {
        employeeData = employeeData.sorted {$0.full_name < $1.full_name}
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tableview.hideSkeleton()
            self.tableview.stopSkeletonAnimation()
        }
        tableview.reloadData()
        
    }
    
    @objc func pullToRefresh() {
        loadEmployeeData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableview.refreshControl?.endRefreshing()
        }
    }

}

extension UITableView {
    func emptyTableView(titleText: String, messageText: String) {
        
        let emptyTableView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.frame.width, height: self.frame.height))
        let title = UILabel()
        let message = UILabel()
        
        emptyTableView.addSubview(title)
        emptyTableView.addSubview(message)
        
        //title
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = UIColor(named: "textColor")
        title.numberOfLines = 0
        title.textAlignment = .center
        title.text = titleText
        title.centerXAnchor.constraint(equalTo: emptyTableView.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: emptyTableView.centerYAnchor).isActive = true
        
        //message
        message.translatesAutoresizingMaskIntoConstraints = false
        message.textColor = .lightGray
        message.numberOfLines = 0
        message.textAlignment = .center
        message.text = messageText
        message.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15).isActive = true
        message.leftAnchor.constraint(equalTo: emptyTableView.leftAnchor, constant: 20).isActive = true
        message.rightAnchor.constraint(equalTo: emptyTableView.rightAnchor, constant: -20).isActive = true
        
        self.backgroundView = emptyTableView
    }
    
    func restoreTableView() {
        
        self.backgroundView = nil
    }
}
