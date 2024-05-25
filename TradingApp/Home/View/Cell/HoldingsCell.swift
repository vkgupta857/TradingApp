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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ltpLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ltpPriceLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let netQtyLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let netQtyValueLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let pnlLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pnlValueLbl: UILabel = {
        let label = UILabel()
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI() {
        selectionStyle = .none
        
        self.contentView.addSubview(scripLbl)
        NSLayoutConstraint.activate([
            scripLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            scripLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            scripLbl.bottomAnchor.constraint(equalTo: scripLbl.topAnchor, constant: 16),
        ])
        
        self.contentView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: scripLbl.bottomAnchor, constant: 16),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureCell(model: UserHolding) {
        scripLbl.text = model.symbol
    }
}
