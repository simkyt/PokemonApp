//
//  ViewController.swift
//  PokemonApp
//
//  Created by arturs.olekss on 06/11/2023.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    private var cellID = "pokemonCell"
    var pokey:[Card] = []
    private let pokemonService = PokemonService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadPokemonData()
    }
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        tableView.register(PokeyTableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBarView()
    }
    
    private func setupNavigationBarView() {
        title = "Pokemon App"
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func loadPokemonData(){
        pokemonService.fetchPokemonData { cards in
            DispatchQueue.main.async {
                if let cards = cards {
                    self.pokey = cards
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - Table view data source
extension PokemonTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pokey.count == 0 {
            tableView.setEmptyView(title: "Fetching the pokemon data...", message: "Please wait...")
        } else {
            tableView.restoreTableViewStyle()
        }
        
        return pokey.count
    }
    
 
    override func tableView(_ tableView:UITableView,cellForRowAt indexPath:IndexPath)->UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell",for: indexPath) as? PokeyTableViewCell else{
            return UITableViewCell()
        }
        let pokey = pokey[indexPath.row]
        cell.setupUI(withDataFrom: pokey)
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokey[indexPath.row]
        
        let detailViewController = PokemonDetailViewController()
        detailViewController.pokemon = selectedPokemon
        navigationController?.pushViewController(detailViewController, animated: true)
    }
   
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont(name: "Futura-Medium", size: 18)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            
            activityIndicator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            activityIndicator.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        ])
        
        titleLabel.text = title
        
        self.backgroundView = emptyView
        self.separatorStyle = .singleLine
    }
    
    func restoreTableViewStyle() {
        self.backgroundView = nil
    }
}

