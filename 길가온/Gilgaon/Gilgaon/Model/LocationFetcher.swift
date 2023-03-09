import CoreLocation
import SwiftUI
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate,ObservableObject {
    let manager = CLLocationManager()
    @Published var recentLocation: CLLocationCoordinate2D?
//    @Published var lineDraw: MKPolyline?
    @Published var points: [CLLocationCoordinate2D] = [
        // TEST
//        CLLocationCoordinate2D(latitude: 37.25062407449622, longitude: 127.0635877387619),
//        CLLocationCoordinate2D(latitude: 37.25111939891473, longitude: 127.0639310615158),
//        CLLocationCoordinate2D(latitude: 37.251384139941024, longitude: 127.06349117923736),
    ]
    

    override init() {
        super.init()
        manager.delegate = self
    }

    
    func setLocationManager() async {
//        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        Task {
            if CLLocationManager.locationServicesEnabled() {
                manager.startUpdatingLocation()
                manager.delegate = self
            } else {
                print("[Fail] 위치 서비스 off 상태 ")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        if let location = locations.first {
            recentLocation = location.coordinate
        }
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        
        if let recentLocation = self.recentLocation {
            print(" ##Count:\(points.count)")
            //현재위치의 좌표 (START)
            let point1 = CLLocationCoordinate2DMake(recentLocation.latitude, recentLocation.longitude)
            //위치정보의 마지막값 (LAST)
            let point2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
//            points.append(point1)
            points.append(point2)
//            let lineDraw = MKPolyline(coordinates: points, count: points.count)
//            self.lineDraw = lineDraw
        }
        self.recentLocation = location.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedAlways, .authorizedWhenInUse:
//            print("== 사용자가 위치를 받겠다고 알림 ==")
//            DispatchQueue.main.async {
//                if CLLocationManager.locationServicesEnabled() {
//                    self.manager.requestLocation()
//                    print(self.manager.location?.coordinate)
//                } else {
//                    print("위치 서비스 off")
//                }
//            }
////            manager.startUpdatingLocation()
//        case .restricted, .notDetermined:
////            getLocation
//            print("== 아직 사용자의 위치 설정되지 않음 ==")
//        case .denied:
//            print("== 사용자가 위치를 받지 않음을 알림 ==")
//        default:
//            print("GPS Default")
//        }
//    }
}
