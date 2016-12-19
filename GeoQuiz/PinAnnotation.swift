//
//  PinAnnotation.swift
//  GeoQuiz
//
//  Created by Jervin Cruz on 12/11/16.
//  Copyright © 2016 Jervin Cruz. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class PinAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    var title: String? = ""
    var subtitle: String? = ""
    var tag: Int?
    var points: Int?
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
}
