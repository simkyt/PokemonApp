//
//  PokemonDetailView.swift
//  PokemonApp
//
//  Created by Simonas Kytra on 07/11/2023.
//

import UIKit

class PokemonDetailView: UIView {
    let scrollView = UIScrollView()
    let contentStackView = UIStackView()
    let imageStackView = UIStackView()
    let labelStackView = UIStackView()
    
    let imageView = UIImageView()
    
    let artistLabel = UILabel()
    let supertypeLabel = UILabel()
    let hpLabel = UILabel()
    let typeLabel = UILabel()
    let rarityLabel = UILabel()
    let seriesLabel = UILabel()
    let subtypeLabel = UILabel()
    let evolvesFromLabel = UILabel()
    let pokedexLabel = UILabel()
    let attacksLabel = UILabel()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        supertypeLabel.translatesAutoresizingMaskIntoConstraints = false
        hpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        rarityLabel.translatesAutoresizingMaskIntoConstraints = false
        seriesLabel.translatesAutoresizingMaskIntoConstraints = false
        subtypeLabel.translatesAutoresizingMaskIntoConstraints = false
        evolvesFromLabel.translatesAutoresizingMaskIntoConstraints = false
        pokedexLabel.translatesAutoresizingMaskIntoConstraints = false
        attacksLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistLabel.textAlignment = .center
        attacksLabel.numberOfLines = 0
        attacksLabel.lineBreakMode = .byWordWrapping
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 25
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.axis = .vertical
        imageStackView.spacing = 10
        labelStackView.axis = .vertical
        labelStackView.spacing = 10
        
        addSubview(scrollView)
        
        contentStackView.addArrangedSubview(imageStackView)
        contentStackView.addArrangedSubview(labelStackView)
        
        scrollView.addSubview(contentStackView)
        
        labelStackView.addArrangedSubview(pokedexLabel)
        labelStackView.addArrangedSubview(supertypeLabel)
        labelStackView.addArrangedSubview(subtypeLabel)
        labelStackView.addArrangedSubview(hpLabel)
        labelStackView.addArrangedSubview(typeLabel)
        labelStackView.addArrangedSubview(rarityLabel)
        labelStackView.addArrangedSubview(seriesLabel)
        labelStackView.addArrangedSubview(evolvesFromLabel)
        labelStackView.addArrangedSubview(attacksLabel)
        
        imageStackView.addArrangedSubview(activityIndicator)
        imageStackView.addArrangedSubview(imageView)
        imageStackView.addArrangedSubview(artistLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            imageView.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        imageView.contentMode = .scaleAspectFit
        activityIndicator.startAnimating()
    }

    func updateImage(_ image: UIImage?) {
        activityIndicator.stopAnimating()
        imageView.image = image
    }

    func updateUI(withDataFrom: Card) {
        artistLabel.text = "Artist: " + (withDataFrom.artist ?? "Unknown")
        
        if let number = withDataFrom.nationalPokedexNumber {
            pokedexLabel.text = "Pokedex number: " + String(number)
        } else {
            pokedexLabel.isHidden = true
        }

        supertypeLabel.text = (withDataFrom.supertype ?? "")
        
        if let subtype = withDataFrom.subtype, subtype != "" {
            subtypeLabel.text = (withDataFrom.subtype ?? "")
        } else {
            subtypeLabel.isHidden = true
        }
        
        if let hp = withDataFrom.hp, hp.lowercased() != "none" {
            hpLabel.text = hp + " ❤️"
        } else {
            hpLabel.isHidden = true
        }
        
        typeLabel.text = (withDataFrom.types?[0] ?? "")
        rarityLabel.text = (withDataFrom.rarity ?? "")
        seriesLabel.text = "Series: " + (withDataFrom.series?.rawValue ?? "")
        
        if let evolvesFrom = withDataFrom.evolvesFrom, evolvesFrom != "" {
            evolvesFromLabel.text = "Evolves from: " + evolvesFrom
        } else {
            evolvesFromLabel.isHidden = true
        }
        
        if let attacks = withDataFrom.attacks {
            let attackNames = attacks.compactMap { $0.name }
            let attacksString = attackNames.joined(separator: ", ")
            attacksLabel.text = "Attacks: " + attacksString
        } else {
            attacksLabel.isHidden = true
        }
    }
}
