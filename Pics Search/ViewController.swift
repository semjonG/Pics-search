//
//  ViewController.swift
//  Pics Search
//
//  Created by mac on 06.12.2021.
//

import UIKit

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
}

class ViewController: UIViewController {
    
    let urlString = "https://api.unsplash.com/search/photos?page=1&query=office&client_id=0jNpDtsjteqxueEK3azU6s9ePCu9ioo5M4LUPcRt0Vw"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
    }
    
    func fetchPhotos () {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let jsonResults = try JSONDecoder().decode(APIResponse.self, from: data)
                print(jsonResults.results.count)
            }
            catch {
                print(error )
            }
        }
        task.resume()
    }
}

