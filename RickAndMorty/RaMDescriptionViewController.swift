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
    var dataSourceAnother = [DataSourseCases]()
    var arrayOfEpisodes:[String?] = []
    
    var arrayWithEpisodes: [String] = []
    
    let episodesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FirstTypeCell.self, forCellReuseIdentifier: "FirstTypeCell")
        tableView.register(ThirdTypeCell.self, forCellReuseIdentifier: "ThirdTypeCell")
        tableView.register(FourthTypeCell.self, forCellReuseIdentifier: "FourthTypeCell")
        tableView.register(FiveTypeCell.self, forCellReuseIdentifier: "FiveTypeCell")
        tableView.register(SecondTypeCell.self, forCellReuseIdentifier: "SecondTypeCell")
        return tableView
        
    }()
    
    let originlabel:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Origin"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let episodeslabel:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Episodes"
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
        arrayOfEpisodes = data?.episode as! [String?]
        arrayWithEpisodes = optFunc(arrayOfEpisodes)
        dataSourceAnother = createDataSource()
        
        
    }
    func setConstaints() {
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
            let cellOne = tableView.dequeueReusableCell(withIdentifier: "FirstTypeCell") as! FirstTypeCell
            cellOne.personImageView.pin_setImage(from: URL(string: image!))
            cellOne.nameLabel.text = name
            cellOne.statusLabel.text = status
            cellForTableView = cellOne
        case .header(let header):
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "SecondTypeCell") as! SecondTypeCell
            cellTwo.originlabel.text = header
            cellForTableView = cellTwo
        case .infoView(let species, let type, let gender):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTypeCell") as! ThirdTypeCell
            
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "FourthTypeCell") as! FourthTypeCell
            cell.urlIncell = url
            cell.originlabelInCellOne.text = name
            cell.originImageView.image = UIImage(systemName: "moon.stars")
            cellForTableView = cell
        case .episodesView(let url):
            let cell = tableView.dequeueReusableCell(withIdentifier: "FiveTypeCell") as! FiveTypeCell
            cell.urlIncell = url
            cellForTableView = cell
        }
        return cellForTableView!
    }
    
    @objc func actionRightSwipeGesture() {
        navigationController?.popToRootViewController(animated: true)
        
    }
    func optFunc (_ array:[String?]) -> [String] {
        var arr:[String] = []
        for item in 0...array.count - 1 {
            arr.append(array[item]!)
        }
        return arr
    }
    
    func createDataSource() -> [DataSourseCases] {

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

