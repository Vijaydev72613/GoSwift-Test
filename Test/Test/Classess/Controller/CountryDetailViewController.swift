//
//  CountryDetailViewController.swift
//  Test
//
//  Created by Vijay on 7/8/16.
//  Copyright © 2016 Vijay. All rights reserved.
//

import UIKit
import MapKit

// MARK: - Class -

class CountryDetailViewController: ViewController {

    // MARK: - Outlets -
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var officialNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties -
    
    var country : Country?
    
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Initial Setup -
    
    func initialSetup() {
        title = country!.officialName
        flagImageView.sd_setImageWithURL(NSURL(string: country!.flat128UrlString))
        officialNameLabel.text = country!.officialName
        var mapRegion = MKCoordinateRegion()
        mapRegion.center.latitude = country!.latitude
        mapRegion.center.longitude = country!.longitude
        mapRegion.span.latitudeDelta = 1
        mapRegion.span.longitudeDelta = 1
        mapView.region = mapRegion
        
        let pinLocation = CLLocationCoordinate2D(latitude: country!.latitude, longitude: country!.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = pinLocation
        annotation.title = country!.officialName
        mapView.addAnnotation(annotation)
    }

}














