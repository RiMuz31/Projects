//
//  CellWithPersonImage.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 06.09.2023.
//
import UIKit
import Transport
import PINRemoteImage

class ImageCharacterCell: UITableViewCell {
    
    static var identifier = "ImageCharacterCell"
    
    var personImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        return image
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "regerg"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .green
        label.textAlignment = .center
        label.text = "regerg"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let firstTypeCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(firstTypeCellView)
        firstTypeCellView.addSubview(personImageView)
        firstTypeCellView.addSubview(nameLabel)
        firstTypeCellView.addSubview(statusLabel)
        contentView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            
            firstTypeCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            firstTypeCellView.heightAnchor.constraint(equalToConstant: 222).with(999),
            firstTypeCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            firstTypeCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            firstTypeCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            personImageView.centerXAnchor.constraint(equalTo: firstTypeCellView.centerXAnchor),
            personImageView.heightAnchor.constraint(equalToConstant: 160),
            personImageView.widthAnchor.constraint(equalToConstant: 160),
            personImageView.topAnchor.constraint(equalTo: firstTypeCellView.topAnchor, constant: 0),
            
            nameLabel.centerXAnchor.constraint(equalTo: firstTypeCellView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.widthAnchor.constraint(equalToConstant: 250),
            nameLabel.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 10),
            
            statusLabel.centerXAnchor.constraint(equalTo: firstTypeCellView.centerXAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 15),
            statusLabel.widthAnchor.constraint(equalToConstant: 100),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
