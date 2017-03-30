//
//  DoctorProfileViewController.swift
//  MobileTest(SeowYungHoe)
//
//  Created by Seow Yung Hoe on 30/03/2017.
//  Copyright © 2017 Seow Yung Hoe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import MapKit

class DoctorProfileViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var docImageView: UIImageView!
    
    @IBOutlet weak var recommendationsLabel: UILabel!
    
    @IBOutlet weak var scheduleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var doctorMapView: MKMapView!
    
    
    var doct : Doctor?
    var indexPathRow : Int? = 0
    var doc : [Doctor] = []
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        doctorMapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
     
                fetchTest()
        


    }
    
    func fetchTest(){
        
        
        guard
            let doctorID = doct?.id!
            else { return }
        
//        let url = "http://52.76.85.10/test/profile/20.json"
        
        let url = "http://52.76.85.10/test/profile/\(doctorID).json"
        
        Alamofire.request(url).responseJSON(completionHandler: {(response) in
            switch response.result {
            case .success(let responseValue):
                let json = JSON(responseValue)
                for (_,subJson) : (String ,JSON) in json{
                    let dic = Doctor(json: json)
                    self.doc.append(dic)
                    
                    let docAnnotation = MKPointAnnotation()
                    self.docImageView.downloadImage(from: self.doc[self.indexPathRow!].photo)
                    self.recommendationsLabel.text = "\(self.doc[self.indexPathRow!].recommendation!)"
                    self.scheduleLabel.text = self.doc[self.indexPathRow!].schedule
                    self.nameLabel.text = self.doc[self.indexPathRow!].name
                    self.areaLabel.text = self.doc[self.indexPathRow!].area
                    self.specialtyLabel.text = self.doc[self.indexPathRow!].speciality
                    self.currencyLabel.text = self.doc[self.indexPathRow!].currency
                    self.rateLabel.text = "\(self.doc[self.indexPathRow!].rate!)"
                    self.experienceLabel.text = "\(self.doc[self.indexPathRow!].experience!) Years Experience"
                    self.descriptionTextView.text = self.doc[self.indexPathRow!].description
                    
                    docAnnotation.coordinate = CLLocationCoordinate2DMake(self.doc[self.indexPathRow!].latitude!, self.doc[self.indexPathRow!].longitute!)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                    let region:MKCoordinateRegion = MKCoordinateRegionMake(docAnnotation.coordinate, span)
                    
                    self.doctorMapView.addAnnotation(docAnnotation)
                    self.doctorMapView.setRegion(region, animated: true)
                    
                    
                    dump (dic)
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        })
        
    }
    
 
    
 

}

//--------------------------------------------------------Graveyard---------------------------------------------------------------
//    func fetchDoctor() {
//
//
//        let url = "http://52.76.85.10/test/profile/\(doct?.id).json"
//
//        Alamofire.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                var tempDoctor : [Doctor] = []
//
//
//                if let doctors = json.dictionary {
//                    for doctor in doctors {
//
//                        let newDoctor = Doctor(json: doctor.value)
//                        tempDoctor.append(newDoctor)
//                        self.docto.append(newDoctor)
//                        dump(self.docto)
//
//
//                        self.nameLabel.text = self.docto[self.indexPathRow!].name
//                    }
//
//                }
//
//            case .failure(let error):
//                print(error)
//
//            }
//
//        }
//    }
