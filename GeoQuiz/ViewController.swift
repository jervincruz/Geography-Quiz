//
//  ViewController.swift
//  GeoQuiz
//
//  Created by Jervin Cruz on 12/11/16.
//  Copyright © 2016 Jervin Cruz. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class ViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var geoquizTitle: UILabel!
    
    var text = ""
    var text2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        geoquizTitle.font = UIFont(name: "Helvetica", size: 25)
        
        // Set region
        let span = MKCoordinateSpanMake(20, 300)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35, longitude: 130), span: span)
        
            mapView.setRegion(region, animated: true)

        if let path = NSBundle.mainBundle().pathForResource("geoquiz", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                let myStrings = data.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
                
                text2 = text + (String(myStrings))
                text = String(myStrings)
            }
            catch let err as NSError{
                print(err)
            }
        }
    
        text2 = text2.stringByReplacingOccurrencesOfString("[", withString: "")
        text2 = text2.stringByReplacingOccurrencesOfString("]", withString: "")
        text2 = text2.stringByReplacingOccurrencesOfString("\"", withString: "")
        text2 = text2.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        print(text2)
        let fileDataArr = text2.componentsSeparatedByString(",")
        //print(fileDataArr[0])
        countriesFromFile.append(fileDataArr[1])
        countriesFromFile.append(fileDataArr[2])
        countriesFromFile.append(fileDataArr[3])
        countriesFromFile.append(fileDataArr[4])
        countriesFromFile.append(fileDataArr[5])
        //print(countriesFromFile)
        capitalsFromFile.append(fileDataArr[7])
        capitalsFromFile.append(fileDataArr[8])
        capitalsFromFile.append(fileDataArr[9])
        capitalsFromFile.append(fileDataArr[10])
        capitalsFromFile.append(fileDataArr[11])
        //print(capitalsFromFile)
        latitudes.append(fileDataArr[13])
        latitudes.append(fileDataArr[14])
        latitudes.append(fileDataArr[15])
        latitudes.append(fileDataArr[16])
        latitudes.append(fileDataArr[17])
        //print(latitudes)
        longitudes.append(fileDataArr[19])
        longitudes.append(fileDataArr[20])
        longitudes.append(fileDataArr[21])
        longitudes.append(fileDataArr[22])
        longitudes.append(fileDataArr[23])
        
        let philippinesLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudes[0])!, longitude: CLLocationDegrees(longitudes[0])!)
        
        let thailandLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudes[1])!, longitude: CLLocationDegrees(longitudes[1])!)
        
        let indiaLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudes[2])!, longitude: CLLocationDegrees(longitudes[2])!)
        
        let chinaLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudes[3])!, longitude: CLLocationDegrees(longitudes[3])!)
        
        let japanLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudes[4])!, longitude: CLLocationDegrees(longitudes[4])!)
        
        
        // Philippines
        philippines.setCoordinate(philippinesLocation)
        philippines.title = countriesFromFile[0]
        philippines.tag = 0
        
        // Thailand
        thailand.setCoordinate(thailandLocation)
        thailand.title = countriesFromFile[1]
        thailand.tag = 1
        
        // India
        india.setCoordinate(indiaLocation)
        india.title = countriesFromFile[2]
        india.tag = 2
        
        // China
        china.setCoordinate(chinaLocation)
        china.title = countriesFromFile[3]
        china.tag = 3
        
        // Japan
        japan.setCoordinate(japanLocation)
        japan.title = countriesFromFile[4]
        japan.tag = 4
        
        if(showPhilippines){
        mapView.addAnnotation(philippines)
        }
        if(showThailand){
        mapView.addAnnotation(thailand)
        }
        if(showIndia){
        mapView.addAnnotation(india)
        }
        if(showChina){
        mapView.addAnnotation(china)
        }
        if(showJapan){
        mapView.addAnnotation(japan)
        }
        
        pointsLabel.text = "\(points)"
        
        if(correct == true){
            if(chosenCountryTag == 0){
                mapView.removeAnnotation(philippines)
                showPhilippines = false
            }
            else if(chosenCountryTag == 1){
                mapView.removeAnnotation(thailand)
                showThailand = false;
            }
            else if(chosenCountryTag == 2){
                mapView.removeAnnotation(india)
                showIndia = false;
            }
            else if(chosenCountryTag == 3){
                mapView.removeAnnotation(china)
                showChina = false;
            }
            else if(chosenCountryTag == 4){
                mapView.removeAnnotation(japan)
                showJapan = false;
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is PinAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinTintColor = UIColor.purpleColor()
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            /*
            let deleteButton = UIButton(type: UIButtonType.Custom) as UIButton
            deleteButton.frame.size.width = 44
            deleteButton.frame.size.height = 44
            deleteButton.backgroundColor = UIColor.redColor()
            deleteButton.setImage(UIImage(named: "trash"), forState: .Normal)
*/
            
            let rightButton = UIButton(type: UIButtonType.DetailDisclosure)
            rightButton.titleForState(UIControlState.Normal)
            
            //pinAnnotationView.leftCalloutAccessoryView = deleteButton
            pinAnnotationView.rightCalloutAccessoryView = rightButton as UIView
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? PinAnnotation {
            if annotation.tag == 0{
                chosenCountryTag = 0
                chosenCountry = "Philippines"
            }
            if annotation.tag == 1{
                chosenCountryTag = 1
                chosenCountry = "Thailand"
            }
            if annotation.tag == 2{
                chosenCountryTag = 2
                chosenCountry = "India"
            }
            if annotation.tag == 3{
                chosenCountryTag = 3
                chosenCountry = "China"
            }
            if annotation.tag == 4{
                chosenCountryTag = 4
                chosenCountry = "Japan"
            }
        mapView.removeAnnotation(annotation)
        }
        if control == view.rightCalloutAccessoryView{
            performSegueWithIdentifier("toTableView", sender: view)
            wrongCapitals.shuffleInPlace();
        }
    }

}

