//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Simonas Kytra on 07/11/2023.
//

import UIKit

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
            pokemonDetailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonDetailView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pokemonDetailView.widthAnchor.constraint(equalToConstant: 300),
            pokemonDetailView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        if let urlString = pokemon?.imageURLHiRes, let url = URL(string: urlString) {
            loadImage(from: url)
        }
    }
    
    func loadImage(from url: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.pokemonDetailView.updateImage(image)
                    self.pokemonDetailView.updateArtistLabel(with: "Artist: \(self.pokemon?.artist ?? "Unknown")")
                } else {
                    self.pokemonDetailView.updateImage(UIImage(named: "notfound.jpg"))
                }
            }
        }
        task.resume()
    }
}
