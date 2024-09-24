//
//  MoviesVC.swift
//  Movie App
//
//  Created by Bthloo on 24/09/2024.
//

import UIKit

class MoviesVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var moviesList : [MovieElement]?
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.4, height: self.view.frame.width * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCV.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        cell.title.text = moviesList![indexPath.row].title
        return cell
    }
    
    
    
    @IBOutlet weak var moviesCV: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moviesCV.delegate = self
        moviesCV.dataSource = self
    
        
        moviesList = [MovieElement]()
        
        getData()
        
    }
    

   func getData(){
       
       let url = URL(string: "https://my-json-server.typicode.com/horizon-code-academy/fake-movies-api/db")
       
       let request = URLRequest(url: url!)
       
       let session = URLSession(configuration: .default)
       
       let task = session.dataTask(with: request) { [weak self] (data, response, error )in
           
           guard let validData = data else{return}
           
           do{
               let movies = try JSONDecoder().decode(Movie.self, from: validData)
               
               self?.moviesList = movies.movies
               print(movies.movies[0].title)
               
               DispatchQueue.main.async {
                   self?.moviesCV.reloadData()
               }

           }catch let e{
               print(e.localizedDescription)
               
               let alertDialog = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
               
               
               
                  
               alertDialog.addAction(UIAlertAction(title: "Retry", style: .default, handler: { UIAlertAction in
                   self?.getData()
               }))
               
               alertDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
               
               self?.present(alertDialog, animated: true)
               
               
           }
           
       }
       
       task.resume()
       
   }

}
