//
//  Location.swift
//  MapAnnotation
//
//  Created by sehooon on 2022/11/30.
//

import SwiftUI
import MapKit
//MARK: - 장소데이터
struct Location: Identifiable, Equatable{

    
    let name: String
    let cityName: String
    let coordinate: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // Identifiable
    var id: String{
        name + cityName
    }
    
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
