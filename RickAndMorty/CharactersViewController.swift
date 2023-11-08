//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 04.09.2023.
//

import UIKit
import Transport
import DTOObjects

class CharactersViewController: UIViewController {
    
    private var internalArticles = [Character]()
    
    private var characters: CharacterInfo?
    
    private var pageNumber: Int = 1
    
    private var isLoading = false
    
    private let transport = TransportFactory.make()
    
    private var footerView: CharacterFooterForViewController?
    
    private let charactersLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "Characters"
        return label
    }()
    private let CharactersCollection: UICollectionView = {
        let collection:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(CharactersCell.self, forCellWithReuseIdentifier: "CharactersCell")
        collection.register(CharacterFooterForViewController.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CharacterFooterForViewController.reuseID)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .black
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        transport.fetchCharacters(pageNumber) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let chars):
                    self.characters = chars
                    self.internalArticles = chars.results
                    self.pageNumber += 1
                    self.CharactersCollection.reloadData()
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
            CharactersCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            CharactersCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            CharactersCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            CharactersCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            charactersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            charactersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            charactersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            charactersLabel.bottomAnchor.constraint(equalTo: CharactersCollection.topAnchor, constant: -20)
        ])
    }
    private func configureHierarchy() {
        view.addSubview(CharactersCollection)
        view.addSubview(charactersLabel)
        CharactersCollection.delegate = self
        CharactersCollection.dataSource = self
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.internalArticles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell", for: indexPath) as? CharactersCell else {
            assertionFailure()
            return UICollectionViewCell()
        }
        cell.data = self.internalArticles[indexPath.row]
        return cell
    }
}
extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 240)
    }
}
extension CharactersViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DescriptionViewController()
        vc.data = internalArticles[indexPath.row]
        navigationController?.pushViewController(vc,animated: true)
        print(indexPath.row)
    }
}
extension CharactersViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CharacterFooterForViewController.reuseID, for: indexPath) as? CharacterFooterForViewController else {
                assertionFailure()
                return UICollectionReusableView()
            }
                footerView = aFooterView
                footerView?.backgroundColor = .black
                footerView?.isHidden = false
            return aFooterView
            }
        return UICollectionReusableView()
    }
}
extension CharactersViewController {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == internalArticles.count - 2, !self.isLoading {
            loadMoreData()
        }
    }
    func loadMoreData() {
        self.isLoading = true
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            self.transport.fetchCharacters(self.pageNumber) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(let news):
                        self.internalArticles.append(contentsOf: news.results)
                        self.CharactersCollection.reloadData()
                        self.isLoading = false
                        self.pageNumber += 1
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
