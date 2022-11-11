//
//  CollectionViewController.swift
//  zemoga assesment
//
//  Created by Camilo Anzola on 11/11/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    //MARK: - UICollectionViewDelegateFlowLayout

    
    var cats: [Cat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        loadFromAPI()
    }
    
    func loadFromAPI(){
        if let url = URL(string: "https://api.thecatapi.com/v1/breeds") {
            var request = URLRequest(url: url)
            request.addValue("bda53789-d59e-46cd-9bc-2936630fde39", forHTTPHeaderField: "x-api-key")
            request.httpMethod = "GET"
            let dataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                //handle response here
                print(data?.count)
                
                let decoder = JSONDecoder()

                do {
                    let catsList = try decoder.decode([Cat].self, from: data!)
                    print(catsList)
                    self.cats = catsList
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            dataTask.resume()
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.cats.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.setCell(i: String(self.cats[indexPath.row].intelligence), n: self.cats[indexPath.row].name, o: self.cats[indexPath.row].origin, a: String(self.cats[indexPath.row].affection_level))
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       return CGSize(width: 500, height: 180.0)
    }

}


struct Cat: Decodable {
    let name: String
    let origin: String
    let affection_level: Int
    let intelligence: Int
}
