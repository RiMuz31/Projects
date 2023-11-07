//
//  RaMDescriptionViewController.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 05.09.2023.
//

import UIKit
import Foundation
import TransportForRickAndMorty
import PINRemoteImage
import DTOObjects

class RaMDescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum DataSourseCases {
        case imageCharacter (String?,String?,String?)
        case header (String)
        case infoView (String?,String?,String?)
        case originView (String?,String?)
        case episodesView (String)
    }
    
    var data:RaMCharacter? = nil
    private var dataSourceAnother = [DataSourseCases]()
    private var arrayOfEpisodes:[String?] = []
    private var arrayWithEpisodes: [String] = []
    private let episodesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ImageCharacterCell.self, forCellReuseIdentifier: "ImageCharacterCell")
        tableView.register(InfoViewCell.self, forCellReuseIdentifier: "InfoViewCell")
        tableView.register(OriginViewCell.self, forCellReuseIdentifier: "OriginViewCell")
        tableView.register(EpisodesViewCell.self, forCellReuseIdentifier: "EpisodesViewCell")
        tableView.register(HeaderCell.self, forCellReuseIdentifier: "HeaderCell")
        return tableView
        
    }()
    private let originlabel:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Origin"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let episodeslabel:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Episodes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let originView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .init(white: 0.12, alpha: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .black
        view.addSubview(episodesTableView)
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(actionRightSwipeGesture))
        rightGesture.direction = .right
        
        self.view.addGestureRecognizer(rightGesture)
        
        setConstaints()
        arrayOfEpisodes = data?.episode ?? []
        arrayWithEpisodes = optFunc(arrayOfEpisodes)
        dataSourceAnother = createDataSource()
        
        
    }
    private func setConstaints() {
        NSLayoutConstraint.activate([
            episodesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSourceAnother.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowInCellAnother = dataSourceAnother[indexPath.row]
        var cellForTableView: UITableViewCell?
        switch rowInCellAnother {
        case .imageCharacter(let image, let name, let status):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCharacterCell") as? ImageCharacterCell else {
                assertionFailure()
                return UITableViewCell()
            }
            cell.personImageView.pin_setImage(from: URL(string: image!))
            cell.nameLabel.text = name
            cell.statusLabel.text = status
            cellForTableView = cell
        case .header(let header):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell else {
                assertionFailure()
                return UITableViewCell()
            }
            cell.originlabel.text = header
            cellForTableView = cell
        case .infoView(let species, let type, let gender):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoViewCell") as? InfoViewCell else {
                assertionFailure()
                return UITableViewCell()
            }
            cell.infoViewLabelFour.text = species
            if data?.type == "" {
                cell.infoViewLabelFive.text = "None"
            }
            else {
                cell.infoViewLabelFive.text = type
            }
            if data?.gender == "" {
                cell.infoViewLabelSix.text = "None"
            }
            else {
                cell.infoViewLabelSix.text = gender
            }
            cellForTableView = cell
        case .originView(let url, let name):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OriginViewCell") as? OriginViewCell else {
                assertionFailure()
                return UITableViewCell()
            }
            cell.urlIncell = url
            cell.originlabelInCellOne.text = name
            cell.originImageView.image = UIImage(systemName: "moon.stars")
            cellForTableView = cell
        case .episodesView(let url):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesViewCell") as? EpisodesViewCell else {
                assertionFailure()
                return UITableViewCell()
            }
            cell.url = url
            cellForTableView = cell
        }
        return cellForTableView!
    }
    @objc private func actionRightSwipeGesture() {
        navigationController?.popToRootViewController(animated: true)
        
    }
    private func optFunc (_ array:[String?]) -> [String] {
        var arr:[String] = []
        for item in 0...array.count - 1 {
            arr.append(array[item]!)
        }
        return arr
    }
    
    private func createDataSource() -> [DataSourseCases] {
        var array = [DataSourseCases]()
        array.append(contentsOf: [
            .imageCharacter(data?.image, data?.name, data?.status),
            .header("Info"),
            .infoView(data?.species,data?.type,data?.gender),
            .header("Origin"),
            .originView(data?.origin.url, data?.origin.name),
            .header("Episodes")
        ])
        for episode in arrayWithEpisodes {
            array.append(.episodesView(episode))
        }
        return array
    }
}

