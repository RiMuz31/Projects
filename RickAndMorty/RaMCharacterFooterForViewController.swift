//
//  RaMCharacterFooterViewController.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 21.09.2023.
//

import UIKit

class RaMCharacterFooterForViewController: UICollectionReusableView {
   
    static let reuseID: String = "footerforViewController"
    
    var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.color = .yellow
        ai.startAnimating()
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupConstraint()
   }
    
    private func setupConstraint() {
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

