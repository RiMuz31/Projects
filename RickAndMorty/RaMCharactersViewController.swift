//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 04.09.2023.
//

import UIKit
import TransportForRickAndMorty
import DTOObjects

class RaMCharactersViewController: UIViewController {
    
    var internalArticles = [RaMCharacter]()
    
    var characters: RaMCharacterInfo?
    
    var numberOfPage: Int = 1
    
    var isLoading = false
    
    let transport = TransportFactory.make()
    
    var footerView: RaMCharacterFooterForViewController?
    
    private let charactersLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "Characters"
        return label
    }()
    private let RaMCharactersCollection: UICollectionView = {
        let collection:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(RaMCharactersCell.self, forCellWithReuseIdentifier: "RaMCharactersCell")
        collection.register(RaMCharacterFooterForViewController.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RaMCharacterFooterForViewController.reuseID)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .black
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        transport.fetchCharacters(numberOfPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let chars):
                    self.characters = chars
                    self.internalArticles = chars.results
                    self.numberOfPage += 1
                    self.RaMCharactersCollection.reloadData()
                    print(self.internalArticles.count)
                    print(self.internalArticles[0].origin.url)
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        configureHierarchy()
        setConstraints()
        self.hideNavigationBar()
        
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            RaMCharactersCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            RaMCharactersCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            RaMCharactersCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            RaMCharactersCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            charactersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            charactersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            charactersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            charactersLabel.bottomAnchor.constraint(equalTo: RaMCharactersCollection.topAnchor, constant: -20)
        ])
    }
    private func configureHierarchy() {
        view.addSubview(RaMCharactersCollection)
        view.addSubview(charactersLabel)
        RaMCharactersCollection.delegate = self
        RaMCharactersCollection.dataSource = self
    }
}

extension RaMCharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.internalArticles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RaMCharactersCell", for: indexPath) as! RaMCharactersCell

        cell.dataForCell = self.internalArticles[indexPath.row]
        
        return cell
    }
}

extension RaMCharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 240)
    }
}

extension RaMCharactersViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = RaMDescriptionViewController()
        vc.data = internalArticles[indexPath.row]
        navigationController?.pushViewController(vc,animated: true)
        print(indexPath.row)
    }
}

extension RaMCharactersViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RaMCharacterFooterForViewController.reuseID, for: indexPath) as! RaMCharacterFooterForViewController
                footerView = aFooterView
                footerView?.backgroundColor = .black
                footerView?.isHidden = false
            return aFooterView
            }
        return UICollectionReusableView()
    }

//    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
//        if elementKind == UICollectionView.elementKindSectionFooter {
//        self.footerView?.activityIndicator.startAnimating()
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
//        if elementKind == UICollectionView.elementKindSectionFooter {
//        self.footerView?.activityIndicator.stopAnimating()
//    }
//    }
}
extension RaMCharactersViewController {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == internalArticles.count - 2, !self.isLoading {
            loadMoreData()
        }
    }
    func loadMoreData() {
        
        self.isLoading = true
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) {
            self.transport.fetchCharacters(self.numberOfPage) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(let news):
                        self.internalArticles.append(contentsOf: news.results)
//                        self.footerView?.activityIndicator.stopAnimating()
//                        self.footerView?.isHidden = true
                        self.RaMCharactersCollection.reloadData()
                        self.isLoading = false
                        self.numberOfPage += 1
                    case .failure(let error):
                        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
