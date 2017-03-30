//
//  ViewController.swift
//  MobileTest(SeowYungHoe)
//
//  Created by Seow Yung Hoe on 29/03/2017.
//  Copyright © 2017 Seow Yung Hoe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchDoctorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var FindDoctorButton: UIButton!{
        didSet{
            FindDoctorButton.addTarget(self, action: #selector(fetchAddress), for: .touchUpInside)
        }
        
    }

    
    //Constant and Variables
    var doctorLocation : [Location] = []
    var FilteredDoctorLocation = [Location]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.tableHeaderView = searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            FilteredDoctorLocation = doctorLocation
        }else {
            FilteredDoctorLocation = doctorLocation.filter({($0.area?.lowercased().contains(searchController.searchBar.text!.lowercased()))!})
        }
        self.tableView.reloadData()
    }

    
  

    func fetchAddress() {
        
        let url = "http://52.76.85.10/test/location.json"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var tempLocation : [Location] = []
                
                
                if let locations = json.array{
                    for location in locations {
                        
                        let newLocation = Location(json: location)
                            tempLocation.append(newLocation)
                        self.doctorLocation.append(newLocation)
                        self.FilteredDoctorLocation = self.doctorLocation
                
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                
                        case .failure(let error):
                            print(error)
        
    }
    
}
}
    
//------------------------------------TableView Related-----------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return FilteredDoctorLocation.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationNameCell") else {return UITableViewCell()}
            
            cell.textLabel?.text = FilteredDoctorLocation[indexPath.row].area
            cell.detailTextLabel?.text = FilteredDoctorLocation[indexPath.row].city
        
        
        return cell
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: "DoctorListViewController") as? DoctorListViewController else {return}
                
        navigationController?.pushViewController(controller, animated: true)
    }
    
}




