//
//  ViewController.swift
//  ImageTableAssignment
//
//  Created by Suprabha Dhavan on 15/04/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var imgTblView: UITableView!
    var imgArray = [imageDetail]()//[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        imgTblView.dataSource = self
        imgTblView.delegate = self
        loadImgs()
        imgTblView.reloadData()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ImageunsplashTableViewCell", for: indexPath) as? ImageTableViewCell
        print(imgArray[indexPath.row].urls.urlFmStr)
        URLSession.shared.dataTask(with: imgArray[indexPath.row].urls.urlFmStr) {
            (data, response, error) in
            if let error = error {
                print("Error:\(error)")
            }else if let data = data {
                print(data)
                DispatchQueue.main.async {
                    cell!.imgView.image = UIImage(data: data)
                }
            }
        }.resume()
        return cell!
    }
    func loadImgs() {
        let urlKey = "https://api.unsplash.com/photos/?client_id=YouRKEY"
        if let url1 = URL(string: urlKey){
            URLSession.shared.dataTask(with: url1){(data, response, error) in
                if let error = error {
                    print("Error:\(error)")
                }else if let response = response as? HTTPURLResponse, let data = data{
                    print("Code:\(response.statusCode)")
                    do{
                        let decoder = JSONDecoder()
                        let imgDtl = try decoder.decode([imageDetail].self, from: data)
                        self.imgArray.append(contentsOf: imgDtl)
                        print(self.imgArray)
                    }catch{
                        print(error)
                    }
                }
            }.resume()
        }
    }
}

