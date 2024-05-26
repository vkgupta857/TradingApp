//
//  PortfolioSummaryView.swift
//  TradingApp
//
//  Created by Vinod Gupta on 26/05/24.
//

import UIKit

class PortfolioSummaryView: UIView {
    
    let currentLabel = UILabel()
    let currentValueLabel = UILabel()
    let totalLabel = UILabel()
    let totalValueLabel = UILabel()
    let todaysPLLabel = UILabel()
    let todaysPLValueLabel = UILabel()
    let separatorView = UIView()
    let toggleBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        btn.tintColor = .lightGray
        return btn
    }()
    let totalPLLabel = UILabel()
    let totalPLValueLabel = UILabel()
    
    let stackView = UIStackView()
    
    var isExpanded: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Adding subviews
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        toggleBtn.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
//        addSubview(currentLabel)
//        addSubview(totalLabel)
//        addSubview(todaysPLLabel)
//        addSubview(totalPLLabel)
//        addSubview(totalPLValueLabel)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalPLLabel)
        view.addSubview(toggleBtn)
        
        stackView.addArrangedSubview(view)
        stackView.addArrangedSubview(totalPLValueLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            totalPLLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalPLLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            toggleBtn.leadingAnchor.constraint(equalTo: totalPLLabel.trailingAnchor, constant: 4),
            toggleBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toggleBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toggleBtn.topAnchor.constraint(equalTo: view.topAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        // Configure subviews layout
        currentValueLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        todaysPLLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPLLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            currentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            currentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            
//            totalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            totalLabel.topAnchor.constraint(equalTo: currentLabel.bottomAnchor, constant: 8),
//            
//            todaysPLLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            todaysPLLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 8),
        ])
    }
    
    @objc func toggleView(_ sender: UIButton) {
        isExpanded = !isExpanded
        sender.setImage(UIImage(systemName: isExpanded ? "chevron.down" : "chevron.up"), for: .normal)
    }
    
    func configureSummary(holdings: [UserHolding]) {
        currentLabel.text = "Current value*"
        currentValueLabel.text = "₹\(String(format: "%.2f", 0))"
        totalLabel.text = "Total investment*"
        totalValueLabel.text = "₹\(String(format: "%.2f", 0))"
        todaysPLLabel.text = "Today's Profit & Loss*"
        todaysPLValueLabel.text = "₹\(String(format: "%.2f", 0))"
        todaysPLValueLabel.textColor = 0 >= 0 ? .systemGreen : .systemRed
        totalPLLabel.text = "Profit & Loss*"
        totalPLValueLabel.text = "₹\(String(format: "%.2f", 0))"
        totalPLValueLabel.textColor = 0 >= 0 ? .systemGreen : .systemRed
    }
}

