//
//  ViewController.swift
//  TradingApp
//
//  Created by Vinod Gupta on 23/05/24.
//

import UIKit

class HomeViewController: UITabBarController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(HoldingsCell.self, forCellReuseIdentifier: HoldingsCell.identifier)
        return tableView
    }()
    
    let errorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        imageView.tintColor = .lightGray
        view.addSubview(imageView)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Something went wrong"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 72),
            imageView.widthAnchor.constraint(equalToConstant: 72),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let refreshControl = UIRefreshControl()
    
    let portfolioSummaryView = PortfolioSummaryView()
    
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        setupNavigationBar()
        setupUI()
        setupSummaryView()
    }
    
    private func setupNavigationBar() {
        // Set the title
        self.navigationItem.title = "Portfolio"
        
        // Profile button on the left
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(profileButtonTapped))
        self.navigationItem.leftBarButtonItem = profileButton
        
        // Sorting and search buttons on the right
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortButtonTapped))
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        self.navigationItem.rightBarButtonItems = [searchButton, sortButton]
    }
    
    private func setupSummaryView() {
        // Add the summary view
        portfolioSummaryView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(portfolioSummaryView)
        
        NSLayoutConstraint.activate([
            portfolioSummaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            portfolioSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            portfolioSummaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Configure the summary view with sample data
        portfolioSummaryView.configureSummary(holdings: viewModel.holdings)
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        self.view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        self.view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupViewModel() {
        viewModel.holdingsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.portfolioSummaryView.configureSummary(holdings: self?.viewModel.holdings ?? [])
            }
        }
        
        viewModel.apiStateUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.activityIndicator.isHidden = self?.viewModel.state == .loaded
                self?.errorView.isHidden = self?.viewModel.error == nil
                self?.updateError()
                self?.tableView.isHidden = self?.viewModel.error != nil
            }
        }
        
        viewModel.getHoldings()
    }
    
    func updateError() {
        for view in errorView.subviews where type(of: view) == UILabel.self {
            if let label = view as? UILabel {
                label.text = self.viewModel.error
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.viewModel.getHoldings()
    }
    
    @objc private func profileButtonTapped() {
        // Action for profile button tap
        print("Profile button tapped")
    }
    
    @objc private func sortButtonTapped() {
        // Action for sort button tap
        print("Sort button tapped")
    }
    
    @objc private func searchButtonTapped() {
        // Action for search button tap
        print("Search button tapped")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.holdings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HoldingsCell.identifier) as? HoldingsCell else { return UITableViewCell() }
        let model = viewModel.holdings[indexPath.row]
        cell.configureCell(model: model)
        if viewModel.holdings.count - 1 == indexPath.row {
            cell.separatorView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.portfolioSummaryView.frame.height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: self.portfolioSummaryView.frame.height))
        return view
    }
}
