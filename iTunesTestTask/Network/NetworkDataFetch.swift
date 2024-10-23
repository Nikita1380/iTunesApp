//
//  NetworkDataFetch.swift
//  iTunesTestTask
//
//  Created by Никита Козловский on 22.10.2024.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchAlbum(urlString: String, responce: @escaping (AlbumModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(url: urlString) { result in
            
            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode(AlbumModel.self, from: data)
                    responce(albums, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
