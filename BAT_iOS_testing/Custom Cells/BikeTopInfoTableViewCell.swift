//
//  BikeTopInfoTableViewCell.swift
//  BAT_iOS_testing
//
//  Created by Dawei Hao on 2024/9/10.
//

import UIKit

class BikeTopInfoTableViewCell: UITableViewCell {
    
    static let identifier: String = "BikeTopInfoTableViewCell"
    
    let cityLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "台北市"
        label.textColor = Colors.darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let districtLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "松山區"
        label.textColor = Colors.darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let stationNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "台北市"
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "drinkCell")
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupUI () {
        contentView.addSubview(cityLabel)
        contentView.addSubview(districtLabel)
        contentView.addSubview(stationNameLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            districtLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 40),
            stationNameLabel.leadingAnchor.constraint(equalTo: districtLabel.trailingAnchor, constant: 40),
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            districtLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stationNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}

#Preview(traits: .fixedLayout(width: 311, height: 72), body: {
    let bikeInfoTableViewCell = BikeTopInfoTableViewCell()
    return bikeInfoTableViewCell
})
