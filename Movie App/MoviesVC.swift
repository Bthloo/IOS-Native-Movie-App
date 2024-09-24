//
//  MoviesVC.swift
//  Movie App
//
//  Created by Bthloo on 24/09/2024.
//

import UIKit


class MoviesVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var moviesList : [MovieElement]?

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 40.0
        }
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.4, height: self.view.frame.width * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCV.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        cell.title.text = moviesList![indexPath.row].title
        
        
        let imageUrl =  moviesList![indexPath.row].poster
        
        if imageUrl == nil{
            
            let errorImage =  UIImage(named: "error-icon")
            
           // cell.image.backgroundColor = UIColor.lightGray
            
            cell.image.image = errorImage
            
        }else{
            loadImage(from: imageUrl!, imageView: cell.image)

        }
    
        
        
        
       
        return cell
    }
    
    
    
    @IBOutlet weak var moviesCV: UICollectionView!
    
        
    @IBOutlet weak var noInternetLbl: UILabel!
    
    
    @IBOutlet weak var tryAgainBtnOtl: UIButton!
    
    @IBAction func tryAgainBtn(_ sender: Any) {
        checkInternet()
        //getData()
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moviesCV.delegate = self
        moviesCV.dataSource = self
    
//        NotificationCenter.default.addObserver(self, selector: #selector(handleNetworkChange), name: .didChangeNetworkStatus, object: nil)
        
        moviesList = [MovieElement]()
    
        
        setupActivityIndicator()
        //checkInternet()
        getData()
        
    }
    
    
    @objc func handleNetworkChange(notification: Notification) {
            if let isConnected = notification.userInfo?["isConnected"] as? Bool {
                print("Network connection changed: \(isConnected ? "Connected" : "Not Connected")")
            }
        }
    
    
    var activityIndicator: UIActivityIndicatorView!
    
    func setupActivityIndicator() {
           activityIndicator = UIActivityIndicatorView(style: .large)
           activityIndicator.center = self.view.center
           activityIndicator.hidesWhenStopped = true
           self.view.addSubview(activityIndicator)
       }
    

   func getData(){
    
      
       print("start fetch")
       activityIndicator.startAnimating()
       
       let url = URL(string: "https://my-json-server.typicode.com/horizon-code-academy/fake-movies-api/db")
       
       let request = URLRequest(url: url!)
       
       let session = URLSession(configuration: .default)
       
       let task = session.dataTask(with: request) { [weak self] (data, response, error )in
           
          
           guard let validData = data else{return}
           
           do{
               let movies = try JSONDecoder().decode(Movie.self, from: validData)
               
               self?.moviesList = movies.movies
        
               
               DispatchQueue.main.async{
                   self?.activityIndicator.stopAnimating()
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
     //
       task.resume()
      
   }
    
    
    
    
    
    
    func loadImage(from urlString: String, imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
      
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Error decoding image data")
                return
            }
            
        
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        
        task.resume()
    }
    
    
    
    func checkInternet(){
        
        if NetworkManager.shared.checkConnection() {
            
            getData()
            self.moviesCV.isHidden = false
            self.moviesCV.reloadData()
        }else{
            print("no Internet")
            self.moviesCV.isHidden = true
                    
        }
        
    }
    
    
    deinit {
            NotificationCenter.default.removeObserver(self)
        }

}
