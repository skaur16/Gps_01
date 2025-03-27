//
//  ViewController.swift
//  Gps_01
//
//  Created by user270251 on 3/10/25.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController ,
                        CLLocationManagerDelegate,
                      MKMapViewDelegate{
    
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    
    @IBOutlet weak var currentSpeedValue: UILabel!
    
    @IBOutlet weak var maxSpeedValue: UILabel!
    
    @IBOutlet weak var distanceValue: UILabel!
    
    @IBOutlet weak var avgSpeedValue: UILabel!
    
    @IBOutlet weak var maxAccelerationValue: UILabel!
    
    @IBOutlet weak var topBar: UIView!
    	
    @IBOutlet weak var bottomBar: UIView!
    
    var locationManager = CLLocationManager()
    var maxSpeed : CLLocationSpeed = 0.0
    var userLocation : CLLocation?
    var previousLocation : CLLocation?
    
    var totalSpeed : CLLocationSpeed = 0.0
    var speedNums = 0
    var totalDistance = 0.0
    var maxAcceleration = 0.0
    var lastSpeed : Double = 0.0
    var lastLocation: CLLocation?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        map.delegate = self
    }
    
    @IBAction func startDirection(_ sender: Any) {
        locationManager.startUpdatingLocation()
        topBar.backgroundColor = UIColor.gray
        bottomBar.backgroundColor = UIColor.green
      
    }
    
    
    @IBAction func stopDirection(_ sender: Any) {
        locationManager.delegate = self
        locationManager.stopUpdatingLocation()
        topBar.backgroundColor = UIColor.gray
        bottomBar.backgroundColor = UIColor.gray
        map.delegate = self
        currentSpeedValue.text = String("0 km/h")
                maxSpeedValue.text = String("0 km/h")
                distanceValue.text = String("0 km")
                avgSpeedValue.text = String("0 km/h")
                maxAccelerationValue.text = String("0 m/s^2")
        
    }
    	

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentLocation = locations.last else{
            return
        }
        var currentSpeed = currentLocation.speed
        currentSpeed = currentSpeed * 3.6
        if(currentSpeed > 0){
            currentSpeedValue.text = String("\(currentSpeed)km/h")
            //updating maxspeed
            if(currentSpeed > maxSpeed){
                maxSpeed = currentSpeed
                maxSpeedValue.text = String("\(maxSpeed)km/h")
            }
            //updating topbar
            if(currentSpeed > 115){
                topBar.backgroundColor = UIColor.red
            }
        }
        else{
            currentSpeedValue.text = String("\(0)km/h")
            //maxSpeed updation
            maxSpeedValue.text = String("\(maxSpeed)km/h")
        }
        //calculating average speed
        let speed = currentLocation.speed
        if(speed > 0){
            totalSpeed += speed
            speedNums += 1
        }
        var avgSpeed = totalSpeed/Double(speedNums)
        avgSpeed = avgSpeed * 3.6
        avgSpeedValue.text = String("\(avgSpeed)km/h")
        
       
        
        
        //calculating distance
        if let previousLocation = previousLocation {
            let distance = currentLocation.distance(from: previousLocation)
            totalDistance += distance
            totalDistance = totalDistance/1000
            distanceValue.text = String("\(totalDistance)km")
            
            //calculating max acceleration
            let timeInterval = currentLocation.timestamp.timeIntervalSince(previousLocation.timestamp)
            var acceleration = (speed - lastSpeed)/Double(timeInterval)
            acceleration = acceleration * 1000
            if(acceleration > maxAcceleration){
                maxAcceleration = acceleration
            }
        }
        previousLocation = currentLocation
        lastSpeed = speed
        maxAccelerationValue.text = String("\(maxAcceleration)m/s^2")
       
        
        //adding annotations
        userLocation = currentLocation
        guard let userLocation = userLocation else { return }
                    
        // Clear previous annotations to avoid clutter
        map.removeAnnotations(map.annotations)
                        
        // Create an annotation for the current location
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.coordinate = userLocation.coordinate
        currentAnnotation.title = "Current Location"
                        
        // Add the current location annotation
        map.addAnnotation(currentAnnotation)

        // Update the map region to follow the user
                    
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        map.setRegion(region,animated:true)
        
    }
    

    //used to set the polyline
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
               let renderer = MKPolylineRenderer(overlay: overlay)
               renderer.strokeColor = .blue // Set the route line color to blue
               renderer.lineWidth = 3 // Set the line thickness
               return renderer
           }
    
  
   

    
}

