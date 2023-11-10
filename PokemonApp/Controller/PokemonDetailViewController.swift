//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Simonas Kytra on 07/11/2023.
//

import UIKit
import SDWebImage

class PokemonDetailViewController : UIViewController {
    var pokemon: Card?
    private let pokemonDetailView = PokemonDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .secondarySystemBackground
        
        title = pokemon?.name
        view.addSubview(pokemonDetailView)
        
        pokemonDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pokemonDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pokemonDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        if let urlString = pokemon?.imageURLHiRes, let url = URL(string: urlString) {
            loadImage(from: url)
        }
    }
    
    func loadImage(from url: URL) {
        SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { [weak self] (image, data, error, cacheType, finished, imageURL) in
                DispatchQueue.main.async {
                    if let image = image {
                        self?.pokemonDetailView.updateImage(image)
                        self?.pokemonDetailView.updateUI(withDataFrom: self!.pokemon!)
                    } else {
                        self?.pokemonDetailView.updateImage(UIImage(named: "notfound.jpg"))
                    }
                }
            }
    }
}
