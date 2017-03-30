//
//  DoctorListViewController.swift
//  MobileTest(SeowYungHoe)
//
//  Created by Seow Yung Hoe on 29/03/2017.
//  Copyright © 2017 Seow Yung Hoe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DoctorListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var doctorTableView: UITableView!
    
    var DoctorsArray: [Doctor] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doctorTableView.register(DoctorCell.cellNib, forCellReuseIdentifier: DoctorCell.cellIdentifier)
        doctorTableView.delegate = self
        doctorTableView.dataSource = self
        fetchDoctor()

    }
    

    func fetchDoctor() {
        
        let url = "http://52.76.85.10/test/datalist.json"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var tempDoctor : [Doctor] = []
                
                
                if let doctors = json.array{
                    for doctor in doctors {
                        
                        let newDoctor = Doctor(json: doctor)
                        tempDoctor.append(newDoctor)
                        self.DoctorsArray.append(newDoctor)

                    }
                    
                    DispatchQueue.main.async {
                        self.doctorTableView.reloadData()
                    }
                    
                }
                
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
    
    
    
    
    //------------------------------------TableView Related-----------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DoctorsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let doc = DoctorsArray[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorCell.cellIdentifier, for: indexPath) as? DoctorCell else {
            return UITableViewCell()
        }
        
        cell.doctorNameLabel.text = doc.name
        cell.doctorAreaLabel.text = doc.area
        cell.doctorSpecialityLabel.text = doc.speciality
        cell.currencyLabel.text = doc.currency
        cell.rateLabel.text! = "\(doc.rate!)"
        cell.doctorImageView.downloadImage(from: DoctorsArray[indexPath.row].photo)
    
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: "DoctorProfileViewController") as? DoctorProfileViewController else {return}
      
        let selectedDoctor = DoctorsArray[indexPath.row]
        
        controller.doct =  selectedDoctor
   
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

extension UIImageView {

    func downloadImage(from imgURL: String!){
        let url = URLRequest(url: URL(string: imgURL)!)
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        
        task.resume()
    }

}

