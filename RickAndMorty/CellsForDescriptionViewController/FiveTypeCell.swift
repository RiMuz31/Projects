//
//  CellWithEpisodes.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 06.09.2023.
//

import UIKit
import TransportForRickAndMorty
import Storage
import DTOObjects

class FiveTypeCell: UITableViewCell {
    
    static var identifier = "FiveTypeCell"
//    var episode: RaMEpisode?
    
    var urlIncell: String? {
        didSet {
           
            guard let url = urlIncell else { return }
            
            self.episodeslabelName.text = nil
            self.episodeslabelNumber.text = nil
            self.episodeslabelData.text = nil
            
            if CashDataEpisodes.shared.getEpisode(from: url) == nil {
//                print(CashDataEpisodes.shared.cashDict[url])
                
                let transport = TransportFactory.make()
                transport.fetchEpisode(url) { [weak self] result in
                    if url == self?.urlIncell {
                    DispatchQueue.main.async {
                   
                        
                        guard let self = self else { return }
                        switch result {
                        case .success(let episode):
                            
                            CashDataEpisodes.shared.setEpisode(episode, with: url)
                            
                            
                            self.episodeslabelName.text = episode.name
                            self.episodeslabelNumber.text = episode.episode
                            self.episodeslabelData.text = episode.air_date
                                
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    }
                }
            
            }
            else {
                self.episodeslabelName.text = CashDataEpisodes.shared.getEpisode(from: url)?.name
                self.episodeslabelNumber.text = CashDataEpisodes.shared.getEpisode(from: url)?.episode
                self.episodeslabelData.text = CashDataEpisodes.shared.getEpisode(from: url)?.air_date
            }
        
        }
    }
    
    var episodeslabelName:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var episodeslabelNumber:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .green
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var episodeslabelData:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let episodesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .init(white: 0.12, alpha: 1)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        episodesView.addSubview(episodeslabelName)
        episodesView.addSubview(episodeslabelNumber)
        episodesView.addSubview(episodeslabelData)
        contentView.addSubview(episodesView)
        contentView.backgroundColor = .black
        
        NSLayoutConstraint.activate([

            
            episodesView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            episodesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            episodesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            episodesView.heightAnchor.constraint(equalToConstant: 85).with(999),
            episodesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            
            episodeslabelName.topAnchor.constraint(equalTo: episodesView.topAnchor, constant: 15),
            episodeslabelName.leadingAnchor.constraint(equalTo: episodesView.leadingAnchor, constant: 10),
            episodeslabelName.widthAnchor.constraint(equalToConstant: 400),
            episodeslabelName.heightAnchor.constraint(equalToConstant: 20),
            
            episodeslabelNumber.topAnchor.constraint(equalTo: episodeslabelName.bottomAnchor, constant: 20),
            episodeslabelNumber.leadingAnchor.constraint(equalTo: episodesView.leadingAnchor, constant: 10),
            episodeslabelNumber.widthAnchor.constraint(equalToConstant: 300),
            episodeslabelNumber.heightAnchor.constraint(equalToConstant: 15),
            
            episodeslabelData.topAnchor.constraint(equalTo: episodeslabelName.bottomAnchor, constant: 20),
            episodeslabelData.trailingAnchor.constraint(equalTo: episodesView.trailingAnchor, constant: -10),
            episodeslabelData.widthAnchor.constraint(equalToConstant: 300),
            episodeslabelData.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



