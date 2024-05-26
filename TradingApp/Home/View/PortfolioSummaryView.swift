//
//  PortfolioSummaryView.swift
//  TradingApp
//
//  Created by Vinod Gupta on 26/05/24.
//

import UIKit

class PortfolioSummaryView: UIView {
    
    let currentValueLabel = UILabel()
    let totalInvestmentLabel = UILabel()
    let todaysPLLabel = UILabel()
    let totalPLLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Adding subviews
        addSubview(currentValueLabel)
        addSubview(totalInvestmentLabel)
        addSubview(todaysPLLabel)
        addSubview(totalPLLabel)
        
        // Configure subviews layout
        currentValueLabel.translatesAutoresizingMaskIntoConstraints = false
        totalInvestmentLabel.translatesAutoresizingMaskIntoConstraints = false
        todaysPLLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPLLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            currentValueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            totalInvestmentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalInvestmentLabel.topAnchor.constraint(equalTo: currentValueLabel.bottomAnchor, constant: 8),
            
            todaysPLLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            todaysPLLabel.topAnchor.constraint(equalTo: totalInvestmentLabel.bottomAnchor, constant: 8),
            
            totalPLLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalPLLabel.topAnchor.constraint(equalTo: todaysPLLabel.bottomAnchor, constant: 8),
            totalPLLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configureSummary(holdings: [UserHolding]) {
        currentValueLabel.text = "Current value*: ₹ \(String(format: "%.2f", 0))"
        totalInvestmentLabel.text = "Total investment*: ₹ \(String(format: "%.2f", 0))"
        todaysPLLabel.text = "Today's Profit & Loss*: ₹ \(String(format: "%.2f", 0))"
        todaysPLLabel.textColor = 0 >= 0 ? .green : .red
        totalPLLabel.text = "Profit & Loss*: ₹ \(String(format: "%.2f", 0))"
        totalPLLabel.textColor = 0 >= 0 ? .green : .red
    }
}

