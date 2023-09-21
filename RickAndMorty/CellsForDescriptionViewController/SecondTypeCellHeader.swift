//
//  CellSecondType.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 12.09.2023.
//
import UIKit
class SecondTypeCell: UITableViewCell {
    
    static var identifier = "SecondTypeCell"
    
    let originlabel:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Proto"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let originView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(originView)
        originView.addSubview(originlabel)
       
        contentView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            
            originView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            originView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            originView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            originView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            originView.heightAnchor.constraint(equalToConstant: 50).with(999),
            
            originlabel.topAnchor.constraint(equalTo: originView.topAnchor, constant: 15),
            originlabel.leadingAnchor.constraint(equalTo: originView.leadingAnchor, constant: 0),
            originlabel.trailingAnchor.constraint(equalTo: originView.trailingAnchor, constant: 0),
            originlabel.bottomAnchor.constraint(equalTo: originView.bottomAnchor, constant: -10),
          
            
            
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
