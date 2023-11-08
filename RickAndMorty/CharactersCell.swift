//
//  RaMCharactersCell.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 04.09.2023.
//

import Foundation
import UIKit
import Transport
import PINRemoteImage
import DTOObjects

class CharactersCell: UICollectionViewCell {
    private static var identifier = "CharactersCell"
    var data: Character? {
        didSet {
            guard let data = data else { return }
            imageInCell.pin_setImage(from: URL(string: data.image))
            titleLabel.text = data.name
        }
    }
    private var titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    private var imageInCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageInCell)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .init(white: 0.12, alpha: 1)
        contentView.layer.cornerRadius = 12
 
    NSLayoutConstraint.activate([
        imageInCell.topAnchor.constraint(equalTo: contentView.topAnchor),
        imageInCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
        imageInCell.rightAnchor.constraint(equalTo:contentView.rightAnchor,constant: -0),
        imageInCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
        titleLabel.topAnchor.constraint(equalTo: imageInCell.bottomAnchor),
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
        titleLabel.rightAnchor.constraint(equalTo:contentView.rightAnchor,constant: -0),
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5)
            ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

