//
//  PokemonTableViewCell.swift
//  PokemonApp
//
//  Created by Simonas Kytra on 10/11/2023.
//

import UIKit
import SDWebImage

class PokeyTableViewCell: UITableViewCell {
    
    let pokeyImageView = UIImageView()
    let nameLabel = UILabel()
    let supertypeLabel = UILabel()
    let artistLabel = UILabel()
    let hpLabel = UILabel()
    let mainStackView = UIStackView()
    let labelsStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fill
        labelsStackView.spacing = 10
        
        artistLabel.numberOfLines = 2
        artistLabel.lineBreakMode = .byWordWrapping
        
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byWordWrapping
        
        [nameLabel, supertypeLabel, artistLabel, hpLabel].forEach { labelsStackView.addArrangedSubview($0) }
        
        [pokeyImageView, labelsStackView].forEach { mainStackView.addArrangedSubview($0) }
        
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        pokeyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokeyImageView.widthAnchor.constraint(equalToConstant: 150),
            pokeyImageView.heightAnchor.constraint(equalToConstant: 200),
            pokeyImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
            pokeyImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 20),
            pokeyImageView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI (withDataFrom: Card) {
        nameLabel.text = "Name: " + withDataFrom.name
        
        if let hp = withDataFrom.hp, hp.lowercased() != "none" {
            hpLabel.text = hp + " ❤️"
        } else {
            hpLabel.text = ""
        }
        
        supertypeLabel.text = (withDataFrom.supertype ?? "")
        artistLabel.text = "Artist: " + (withDataFrom.artist ?? "Unknown")
        pokeyImageView.sd_setImage(with: URL(string:withDataFrom.imageURL))
    }
}
