//
//  EmployeeCellTableViewCell.swift
//  SquareTest
//
//  Created by Srivalli Kanchibotla on 6/5/23.
//

import UIKit
import SkeletonView

class EmployeeCellTableViewCell: UITableViewCell {

    static let identifier = "employeeCell"
    
    var employeeCellTitle = UILabel()
    var employeeCellSubTitle = UILabel()
    var employeeCellDescription = UILabel()
    var employeeImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        employeeImage = UIImageView(image: UIImage(systemName: "person.crop.square.fill"))
        employeeImage.tintColor = .lightGray
        contentView.addSubview(employeeImage)
        contentView.addSubview(employeeCellTitle)
        contentView.addSubview(employeeCellSubTitle)
        contentView.addSubview(employeeCellDescription)
        configureEmployeeCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureEmployeeCell() {
        
        //image
        employeeImage.clipsToBounds = true
        employeeImage.layer.cornerRadius = 10
        employeeImage.contentMode = .scaleAspectFill
        employeeImage.isSkeletonable = true
        
        employeeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            employeeImage.heightAnchor.constraint(equalToConstant: 90),
            employeeImage.widthAnchor.constraint(equalToConstant: 90),
            employeeImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        //title
        employeeCellTitle.numberOfLines = 0
        employeeCellTitle.adjustsFontSizeToFitWidth = true
        employeeCellTitle.text = ""
        employeeCellTitle.font = .systemFont(ofSize: 16, weight: .bold)
        employeeCellTitle.isSkeletonable = true
        
        employeeCellTitle.translatesAutoresizingMaskIntoConstraints = false
        employeeCellTitle.leadingAnchor.constraint(equalTo: employeeImage.trailingAnchor, constant: 10).isActive = true
        employeeCellTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        employeeCellTitle.preferredMaxLayoutWidth = 180
        
        //subtitle
        employeeCellSubTitle.numberOfLines = 0
        employeeCellSubTitle.adjustsFontSizeToFitWidth = true
        employeeCellSubTitle.text = ""
        employeeCellSubTitle.font = .systemFont(ofSize: 14, weight: .semibold)
        employeeCellSubTitle.isSkeletonable = true
        
        employeeCellSubTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeeCellSubTitle.leadingAnchor.constraint(equalTo: employeeImage.trailingAnchor,constant: 10),
            employeeCellSubTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            employeeCellSubTitle.topAnchor.constraint(equalTo: employeeCellTitle.bottomAnchor, constant: 6)
        ])
        
        //description
        employeeCellDescription.numberOfLines = 0
        employeeCellDescription.adjustsFontSizeToFitWidth = true
        employeeCellDescription.text = ""
        employeeCellDescription.font = .systemFont(ofSize: 12, weight: .regular)
        employeeCellDescription.isSkeletonable = true
        
        employeeCellDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeeCellDescription.leadingAnchor.constraint(equalTo: employeeImage.trailingAnchor,constant: 10),
            employeeCellDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            employeeCellDescription.topAnchor.constraint(equalTo: employeeCellSubTitle.bottomAnchor, constant: 6)
        ])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
