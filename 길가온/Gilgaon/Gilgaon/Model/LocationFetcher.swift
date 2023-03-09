import CoreLocation
import SwiftUI
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate,ObservableObject {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    @Published var recentLocation: CLLocationCoordinate2D?
    @Published var lineDraw: MKPolyline?

    override init() {
        super.init()
        manager.delegate = self
    }

    
    func setLocationManager() async {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
    }
    func locationServicesEnabled() async {
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.manager.requestLocation()
                print(self.manager.location?.coordinate)
            } else {
                print("위치 서비스 off")
            }
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        recentLocation = locations.first?.coordinate
//        print("== recentLocation == :",lastKnownLocation)
        
        if let location = locations.first {
            print("== 위치 업데이트 ==")
            print("경도: \(location.coordinate.longitude)")
            print("위도: \(location.coordinate.latitude)")
        }
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        
        if let recentLocation = self.recentLocation {
            var points: [CLLocationCoordinate2D] = []
            let point1 = CLLocationCoordinate2DMake(recentLocation.latitude, recentLocation.longitude)
            let point2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
            points.append(point1)
            points.append(point2)
            let lineDraw = MKPolyline(coordinates: points, count: points.count)
            self.lineDraw = lineDraw
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("== 사용자가 위치를 받겠다고 알림 ==")
            DispatchQueue.main.async {
                if CLLocationManager.locationServicesEnabled() {
                    self.manager.requestLocation()
                    print(self.manager.location?.coordinate)
                } else {
                    print("위치 서비스 off")
                }
            }
//            manager.startUpdatingLocation()
        case .restricted, .notDetermined:
//            getLocation
            print("== 아직 사용자의 위치 설정되지 않음 ==")
        case .denied:
            print("== 사용자가 위치를 받지 않음을 알림 ==")
        default:
            print("GPS Default")
        }
    }
}
