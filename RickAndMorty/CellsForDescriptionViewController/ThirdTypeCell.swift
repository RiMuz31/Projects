//
//  CellWithInfo.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 06.09.2023.
//
import UIKit

class ThirdTypeCell: UITableViewCell {
    
    static var identifier = "ThirdTypeCell"

    let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .init(white: 0.12, alpha: 1)
        return view
    }()
    let infoViewLabelOne:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .init(white: 0.70, alpha: 1)
        label.textAlignment = .left
        label.text = "Species:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let infoViewLabelTwo:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .init(white: 0.70, alpha: 1)
        label.textAlignment = .left
        label.text = "Type:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let infoViewLabelThree:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .init(white: 0.70, alpha: 1)
        label.textAlignment = .left
        label.text = "Gender:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var infoViewLabelFour:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "Info"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var infoViewLabelFive:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "Info"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var infoViewLabelSix:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "Info"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       
        contentView.addSubview(infoView)
        infoView.addSubview(infoViewLabelOne)
        infoView.addSubview(infoViewLabelTwo)
        infoView.addSubview(infoViewLabelThree)
        infoView.addSubview(infoViewLabelFour)
        infoView.addSubview(infoViewLabelFive)
        infoView.addSubview(infoViewLabelSix)
        
        contentView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            

            infoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            infoView.heightAnchor.constraint(equalToConstant: 90).with(999),

            infoViewLabelOne.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 10),
            infoViewLabelOne.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15),
            infoViewLabelOne.widthAnchor.constraint(equalToConstant: 200),
            infoViewLabelOne.heightAnchor.constraint(equalToConstant: 15),

            infoViewLabelTwo.topAnchor.constraint(equalTo: infoViewLabelOne.bottomAnchor, constant: 10),
            infoViewLabelTwo.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15),
            infoViewLabelTwo.widthAnchor.constraint(equalToConstant: 200),
            infoViewLabelTwo.heightAnchor.constraint(equalToConstant: 15),

            infoViewLabelThree.topAnchor.constraint(equalTo: infoViewLabelTwo.bottomAnchor, constant: 10),
            infoViewLabelThree.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15),
            infoViewLabelThree.widthAnchor.constraint(equalToConstant: 200),
            infoViewLabelThree.heightAnchor.constraint(equalToConstant: 15),

            infoViewLabelFour.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 10),
            infoViewLabelFour.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15),
            infoViewLabelFour.widthAnchor.constraint(equalToConstant: 200),
            infoViewLabelFour.heightAnchor.constraint(equalToConstant: 15),

            infoViewLabelFive.topAnchor.constraint(equalTo: infoViewLabelFour.bottomAnchor, constant: 10),
            infoViewLabelFive.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15),
            infoViewLabelFive.widthAnchor.constraint(equalToConstant: 200),
            infoViewLabelFive.heightAnchor.constraint(equalToConstant: 15),

            infoViewLabelSix.topAnchor.constraint(equalTo: infoViewLabelFive.bottomAnchor, constant: 10),
            infoViewLabelSix.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15),
            infoViewLabelSix.widthAnchor.constraint(equalToConstant: 200),
            infoViewLabelSix.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

