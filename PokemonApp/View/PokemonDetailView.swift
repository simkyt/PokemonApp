//
//  PokemonDetailView.swift
//  PokemonApp
//
//  Created by Simonas Kytra on 07/11/2023.
//

import UIKit

class PokemonDetailView: UIView {
    let imageView = UIImageView()
    let artistLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistLabel.textAlignment = .center
        
        addSubview(imageView)
        addSubview(activityIndicator)
        addSubview(artistLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            artistLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            artistLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            artistLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }

    func updateImage(_ image: UIImage?) {
        activityIndicator.stopAnimating()
        imageView.image = image
    }

    func updateArtistLabel(with text: String) {
        artistLabel.text = text
    }
}
