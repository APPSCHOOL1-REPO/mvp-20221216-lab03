//
//  UserMapView.swift
//  Gilgaon
//

//  Created by sehooon on 2023/03/02.
//

import SwiftUI
import UIKit
import MapKit


struct UserMapView: UIViewRepresentable {
    
    var landmarks:[LandmarkAnnotation] = LandmarkAnnotation.mockData
    
    
    
    //  "Description - Replace the body with a make UIView(context:) method that creates and return an empty MKMapView"
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.delegate = context.coordinator
        uiView.addAnnotations(landmarks)
    }
    
    func makeCoordinator() -> UserMapViewCoordinator {
        UserMapViewCoordinator(mapViewController: self)
    }
    
}

// pin annotation
final class LandmarkAnnotation: NSObject, MKAnnotation{
    let markerId = UUID().uuidString
    var title:String?
    var subtitle: String?
    let coordinate: CLLocationCoordinate2D
    static let mockData = [
        LandmarkAnnotation(title: "ff", subtitle: "ggg", coordinate: CLLocationCoordinate2D(latitude: 37.562959200045654, longitude: 126.83252062990505)),
        LandmarkAnnotation(title: "jj", subtitle: "ggg", coordinate: CLLocationCoordinate2D(latitude: 37.52014908427796, longitude: 126.75334198579641)),
        LandmarkAnnotation(title: "kk", subtitle: "ggg", coordinate: CLLocationCoordinate2D(latitude: 37.54053029363062, longitude: 126.88217608491355)),
        LandmarkAnnotation(title: "ll", subtitle: "ggg", coordinate: CLLocationCoordinate2D(latitude: 37.4802505761054, longitude: 126.86309586052927 )),
        LandmarkAnnotation(title: "oo", subtitle: "ggg", coordinate: CLLocationCoordinate2D(latitude: 37.46442606194599, longitude:  126.89567907400533 ))
    ]
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}


class UserMapViewCoordinator: NSObject, MKMapViewDelegate{
    var mapViewController: UserMapView
    
    
    init(mapViewController: UserMapView) {
        self.mapViewController = mapViewController
    }
    
    // mapAnnotationSelected
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        let annotationimageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImage(named: "flowerPink")
        annotationimageView.image = image
        let annotationLabel = UILabel(frame: CGRect(x: 0, y: -35, width: 45, height: 15))
        annotationLabel.backgroundColor = .systemOrange
        annotationLabel.textColor = .white
        annotationLabel.numberOfLines = 3
        annotationLabel.textAlignment = .center
        annotationLabel.font = UIFont.boldSystemFont(ofSize: 10)
        annotationLabel.text = annotation.title!
        annotationView.addSubview(annotationimageView)
        annotationView.addSubview(annotationLabel)
        return annotationView
    }
    
    
}

