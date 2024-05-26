//
//  HoldingsCell.swift
//  TradingApp
//
//  Created by Vinod Gupta on 24/05/24.
//

import UIKit

class HoldingsCell: UITableViewCell {
    
    static var identifier: String { return String(describing: self) }
    
    let scripLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ltpLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ltpPriceLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let netQtyLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let netQtyValueLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let pnlLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pnlValueLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        separatorView.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI() {
        selectionStyle = .none
        
        self.contentView.addSubview(scripLbl)
        self.contentView.addSubview(ltpLbl)
        self.contentView.addSubview(ltpPriceLbl)
        self.contentView.addSubview(netQtyLbl)
        self.contentView.addSubview(netQtyValueLbl)
        self.contentView.addSubview(pnlLbl)
        self.contentView.addSubview(pnlValueLbl)
        self.contentView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            scripLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            scripLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            scripLbl.bottomAnchor.constraint(equalTo: scripLbl.topAnchor, constant: 16),
            
            ltpPriceLbl.topAnchor.constraint(equalTo: scripLbl.topAnchor),
            ltpPriceLbl.leadingAnchor.constraint(equalTo: ltpLbl.trailingAnchor, constant: 4),
            ltpPriceLbl.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            ltpLbl.centerYAnchor.constraint(equalTo: ltpPriceLbl.centerYAnchor),
            ltpLbl.leadingAnchor.constraint(greaterThanOrEqualTo: scripLbl.trailingAnchor, constant: 16),
            
            netQtyLbl.leadingAnchor.constraint(equalTo: scripLbl.leadingAnchor),
            netQtyLbl.centerYAnchor.constraint(equalTo: netQtyValueLbl.centerYAnchor),
            
            netQtyValueLbl.topAnchor.constraint(equalTo: scripLbl.bottomAnchor, constant: 16),
            netQtyValueLbl.leadingAnchor.constraint(equalTo: netQtyLbl.trailingAnchor, constant: 4),
            
            pnlValueLbl.topAnchor.constraint(equalTo: ltpLbl.bottomAnchor, constant: 16),
            pnlValueLbl.leadingAnchor.constraint(equalTo: pnlLbl.trailingAnchor, constant: 4),
            pnlValueLbl.trailingAnchor.constraint(greaterThanOrEqualTo: ltpPriceLbl.trailingAnchor),

            pnlLbl.centerYAnchor.constraint(equalTo: pnlValueLbl.centerYAnchor),
            pnlLbl.leadingAnchor.constraint(greaterThanOrEqualTo: netQtyValueLbl.trailingAnchor, constant: 16),
        
            separatorView.topAnchor.constraint(equalTo: netQtyValueLbl.bottomAnchor, constant: 16),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureCell(model: UserHolding) {
        scripLbl.text = model.symbol
        ltpLbl.text = "LTP:"
        ltpPriceLbl.text = "₹\(String(format: "%.2f", model.ltp ?? 0))"
        netQtyLbl.text = "NET QTY:"
        netQtyValueLbl.text = "\(model.quantity ?? 0)"
        pnlLbl.text = "P&L:"
        
        let pnl = Double(model.quantity ?? 0) * ((model.ltp ?? 0) - (model.avgPrice ?? 0))
        pnlValueLbl.text = (pnl >= 0 ? "" : "-") + "₹\(String(format: "%.2f", abs(pnl)))"
        pnlValueLbl.textColor = pnl >= 0 ? .systemGreen : .systemRed
    }
}
