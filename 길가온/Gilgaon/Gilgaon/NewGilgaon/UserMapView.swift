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
    @ObservedObject var flowerMapViewModel: FlowerMapViewModel
    
    // func makeUIView() == func body() -> some View {}
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "custom")
        setSubscriber(mapView)
        return mapView
    }
    
    // MARK: - mapView에 "다음장소"버튼 클릭 시, 맵뷰의 Region을 변경
    func setSubscriber( _ mapView: MKMapView){
        flowerMapViewModel.buttonCancellable = flowerMapViewModel.$nextBtnPressed.sink { _ in
            mapView.setRegion(flowerMapViewModel.mapRegions, animated: true)
        }
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.delegate = context.coordinator
        uiView.setRegion(flowerMapViewModel.mapRegions, animated: true)
        uiView.addAnnotations(makePins())
    }
    
    func makeCoordinator() -> UserMapViewCoordinator {
        UserMapViewCoordinator(mapViewController: self)
    }
    
    // mapView에 표시할 Pin생성.
    func makePins() -> [LandmarkAnnotation]{
        var lAT:[LandmarkAnnotation] = []
        for location in flowerMapViewModel.locations{
            if location.id == flowerMapViewModel.mapLocation.id{
                lAT.append(LandmarkAnnotation(markerId: location.id, isSelected: true,coordinate: location.coordinate))
            }else{
                lAT.append(LandmarkAnnotation(markerId: location.id, isSelected: false, coordinate: location.coordinate))
            }
            
        }
        return lAT
    }
}

// pin annotation
final class LandmarkAnnotation: NSObject, MKAnnotation{
    let markerId: String?
    var title:String?
    var subtitle: String?
    var isSelected = false
    let coordinate: CLLocationCoordinate2D
    
    init(markerId: String?, title: String? = nil, subtitle: String? = nil, isSelected: Bool = false, coordinate: CLLocationCoordinate2D) {
        self.markerId = markerId
        self.title = title
        self.subtitle = subtitle
        self.isSelected = isSelected
        self.coordinate = coordinate
    }
}

class UserMapViewCoordinator: NSObject, MKMapViewDelegate{
    var mapViewController: UserMapView
    
    
    init(mapViewController: UserMapView) {
        self.mapViewController = mapViewController
    }
    
    // mapAnnotation 클릭 시, 해당 annotation으로 region 이동.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation =  view.annotation,
              let ViewAnnotation = annotation as? LandmarkAnnotation else { return }
        
        for location in mapViewController.flowerMapViewModel.locations{
            if ViewAnnotation.markerId! == location.id {
                mapViewController.flowerMapViewModel.mapLocation = location
                mapViewController.flowerMapViewModel.updateMapRegions(location)
            }
        }
    }
    
    func setUpImage(_ annotation: LandmarkAnnotation) -> UIImage?{
        var image = UIImage(named: "flowerPink")
        image = image?.resized(to: CGSize(width: 40, height: 40))
        return image
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? LandmarkAnnotation else { return nil }
        
        guard let aView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom") else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView.image = setUpImage(annotation)
            return annotationView
        }
        aView.image = setUpImage(annotation)
        return aView
    }
}

//UIImage Renderer하기
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
