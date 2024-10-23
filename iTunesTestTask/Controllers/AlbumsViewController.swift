//
//  AlbumsViewController.swift
//  iTunesTestTask
//
//  Created by Никита Козловский on 14.10.2024.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    var albums = [Album]()
    var timer: Timer?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setupSearchViewController()
        createNavBar()
        
        fetchAlbums(albumName: "Test")
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
    }
    
    private func createNavBar() {
        navigationItem.title = "Albums"
        navigationItem.searchController = searchController
        
        let userInfoButton = createCustomButton(selector: #selector(userInfoButtonTapped))
        navigationItem.rightBarButtonItem = userInfoButton
    }
    
    private func setupSearchViewController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
    
    func fetchAlbums(albumName: String) {
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] albumModel, error in
            if error == nil {
                guard let albumModel = albumModel else { return }
                
                // - сравниваем названия альбома по алфавиту и выстраиваем в порядке алфавита
                let sortedAlbums = albumModel.results.sorted { firstItem, secondItem in
                    return firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                }
                self?.albums = sortedAlbums
                self?.tableView.reloadData()
                
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    @objc private func userInfoButtonTapped() {
        let userInfoViewController = UserInfoViewController()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension AlbumsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumsTableViewCell else { return UITableViewCell() }
        let album = albums[indexPath.row]
        cell.configureCell(album: album)
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAlbumViewController = DetailAlbumViewController()
        navigationController?.pushViewController(detailAlbumViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate

extension AlbumsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // - делаем задержку в запросе. Пока пользователь вводит текст в searchBar, запрос не происходит
        if searchText != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.fetchAlbums(albumName: searchText)
            })
        }
    }
}
