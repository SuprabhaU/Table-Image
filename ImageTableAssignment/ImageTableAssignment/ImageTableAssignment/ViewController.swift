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
    var imgArray1 = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        imgTblView.dataSource = self
        imgTblView.delegate = self
        loadImgs()
        // Do any additional setup after loading the view.
    }
//    override func viewWillAppear(_ animated: Bool) {
//        imgTblView.dataSource = self
//        imgTblView.delegate = self
//        loadImgs()
////        imgTblView.reloadData()
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imgArray1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ImageunsplashTableViewCell", for: indexPath) as? ImageTableViewCell
        URLSession.shared.dataTask(with: URL(string:imgArray1[indexPath.row])!){
            (data, response, error) in
            DispatchQueue.main.async {
                cell!.imgView.image = UIImage(data: data!)
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
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,AnyObject>]
                        {
                            for i in 0...jsonArray.count-1  {
                                let valForArray = "\(String(describing: "\(jsonArray[i]["urls"]!["small_s3"]! ?? "")"))"
                                let newvalForArray1 = valForArray.replacingOccurrences(of: "Optional(", with: "")
                                let newvalForArray2 = newvalForArray1.replacingOccurrences(of: ")", with: "")
                                self.imgArray1.append(newvalForArray2)
                            }
                            DispatchQueue.main.async {
                                self.imgTblView.reloadData()
                            }
                        } else {
                            print("bad json")
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}

