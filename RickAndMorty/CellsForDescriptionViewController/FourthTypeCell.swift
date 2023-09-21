//
//  CellWithOrigin.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 06.09.2023.
//

import UIKit
import TransportForRickAndMorty

class FourthTypeCell: UITableViewCell {
    
    static var identifier = "FourthTypeCell"
    
    var origin: RaMCharacterOrigin?
    var urlIncell: String? {
        didSet {
            guard let urlInCell = urlIncell else { return }
            let transport = TransportFactory.make()
            transport.fetchOrigin(urlInCell) { [weak self] result in
                        DispatchQueue.global(qos: .userInitiated).async {
                            guard let self = self else { return }
                        switch result {
                        case .success(let chars):
                            self.origin = chars
                            DispatchQueue.main.async {
                                self.originlabelInCellTwo.text = self.origin?.name
                                
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
    
    var originlabelInCellOne:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Origin"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var originlabelInCellTwo:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .green
        label.textAlignment = .left
        label.text = "Unknown"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    let originView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .init(white: 0.12, alpha: 1)
        return view
    }()
    var originImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.backgroundColor = .black
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(originView)
        originView.addSubview(originImageView)
        originView.addSubview(originlabelInCellOne)
        originView.addSubview(originlabelInCellTwo)
        contentView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            
            originView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            originView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            originView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            originView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            originImageView.heightAnchor.constraint(equalToConstant: 65).with(999),
            originImageView.widthAnchor.constraint(equalTo: originImageView.heightAnchor),
            originImageView.topAnchor.constraint(equalTo: originView.topAnchor, constant: 5),
            originImageView.bottomAnchor.constraint(equalTo: originView.bottomAnchor, constant: -5),
            originImageView.leadingAnchor.constraint(equalTo: originView.leadingAnchor, constant: 5),
            
            originlabelInCellOne.topAnchor.constraint(equalTo: originView.topAnchor, constant: 15),
            originlabelInCellOne.leadingAnchor.constraint(equalTo: originImageView.trailingAnchor, constant: 10),
            originlabelInCellOne.widthAnchor.constraint(equalToConstant: 300),
            originlabelInCellOne.heightAnchor.constraint(equalToConstant: 20),
            
            originlabelInCellTwo.topAnchor.constraint(equalTo: originlabelInCellOne.bottomAnchor, constant: 10),
            originlabelInCellTwo.leadingAnchor.constraint(equalTo: originImageView.trailingAnchor, constant: 10),
            originlabelInCellTwo.widthAnchor.constraint(equalToConstant: 300),
            originlabelInCellTwo.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





