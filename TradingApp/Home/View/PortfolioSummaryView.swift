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
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        return view
    }()
    let toggleBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        btn.tintColor = .lightGray
        return btn
    }()
    let totalPLLabel = UILabel()
    let totalPLValueLabel = UILabel()
    
    let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
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
        
        setupCurrentValueStackView()
        setupTotalInvestStackView()
        setupTodaysPLStackView()
        detailsStackView.addArrangedSubview(separatorView)
        
        // Configure subviews layout
        currentValueLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        todaysPLLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPLLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let pnlStackView = UIStackView()
        pnlStackView.translatesAutoresizingMaskIntoConstraints = false
        pnlStackView.axis = .horizontal
        pnlStackView.distribution = .equalSpacing
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalPLLabel)
        view.addSubview(toggleBtn)
        
        pnlStackView.addArrangedSubview(view)
        pnlStackView.addArrangedSubview(totalPLValueLabel)
        
        let containerStackView = UIStackView()
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.axis = .vertical
        containerStackView.spacing = 16
        containerStackView.addArrangedSubview(detailsStackView)
        containerStackView.addArrangedSubview(pnlStackView)
        
        addSubview(containerStackView)
        detailsStackView.isHidden = true
        
        NSLayoutConstraint.activate([
            totalPLLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalPLLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            toggleBtn.leadingAnchor.constraint(equalTo: totalPLLabel.trailingAnchor, constant: 4),
            toggleBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toggleBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toggleBtn.topAnchor.constraint(equalTo: view.topAnchor),

            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @objc func toggleView(_ sender: UIButton) {
        isExpanded = !isExpanded
        sender.setImage(UIImage(systemName: isExpanded ? "chevron.down" : "chevron.up"), for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.detailsStackView.isHidden = !self.isExpanded
        }
    }
    
    func configureSummary(holdings: [UserHolding]) {
        var currentValue: Double = 0
        var totalInvestment: Double = 0
        var todayPNL: Double = 0
        
        for holding in holdings {
            currentValue += (Double(holding.quantity ?? 0) * (holding.ltp ?? 0))
            totalInvestment += (Double(holding.quantity ?? 0) * (holding.avgPrice ?? 0))
            todayPNL += (((holding.close ?? 0) - (holding.ltp ?? 0)) * (Double(holding.quantity ?? 0)))
        }
        
        let totalPNL: Double = currentValue - totalInvestment
        var totalPNLPerc: Double = 0
        if totalInvestment == 0 {
            totalPNLPerc = 0
        } else {
            totalPNLPerc = (totalPNL / totalInvestment) * 100
        }
        
        currentLabel.text = "Current value*"
        currentValueLabel.text = "₹\(String(format: "%.2f", currentValue))"
        totalLabel.text = "Total investment*"
        totalValueLabel.text = "₹\(String(format: "%.2f", totalInvestment))"
        todaysPLLabel.text = "Today's Profit & Loss*"
        todaysPLValueLabel.text = (todayPNL >= 0 ? "" : "-") + "₹\(String(format: "%.2f", abs(todayPNL)))"
        todaysPLValueLabel.textColor = todayPNL >= 0 ? .systemGreen : .systemRed
        totalPLLabel.text = "Profit & Loss*"
        totalPLValueLabel.text = (totalPNL >= 0 ? "" : "-") + "₹\(String(format: "%.2f", abs(totalPNL)))" + "(\(String(format: "%.2f", totalPNLPerc))%)"
        totalPLValueLabel.textColor = totalPNL >= 0 ? .systemGreen : .systemRed
    }
    
    func setupCurrentValueStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(currentLabel)
        stackView.addArrangedSubview(currentValueLabel)
        
        detailsStackView.addArrangedSubview(stackView)
    }
    
    func setupTotalInvestStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(totalLabel)
        stackView.addArrangedSubview(totalValueLabel)
        
        detailsStackView.addArrangedSubview(stackView)
    }
    
    func setupTodaysPLStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(todaysPLLabel)
        stackView.addArrangedSubview(todaysPLValueLabel)
        
        detailsStackView.addArrangedSubview(stackView)
    }
}

