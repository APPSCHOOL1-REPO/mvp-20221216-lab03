//
//  LocationDataService.swift
//  MapAnnotation
//
//  Created by sehooon on 2022/12/01.
//

import Foundation
import MapKit

class LocationsDataService{
    
    
    static var locations: [Location] = [
    Location(
        name: "고고양파",
        cityName: "경기 안산시 단원구 원곡동 906",
        coordinate: CLLocationCoordinate2D(latitude: 37.32436805, longitude: 126.80490476),
        description: "...",
        imageNames: ["b00"],
        link: "dfsdfsdf"),
    
    Location(
        name: "서서갈비",
        cityName: "경기 안산시 단원구 초지동 906",
        coordinate: CLLocationCoordinate2D(latitude: 37.32322935, longitude: 126.80501586),
        description: "...",
        imageNames: ["b03"],
        link: "dfsdfsdf"),
    
    Location(
        name: "스타벅스",
        cityName: "경기 안산시 단원구 고잔동 906",
        coordinate: CLLocationCoordinate2D(latitude: 37.32317380, longitude: 126.80857115),
        description: "...",
        imageNames: ["b07"],
        link: "dfsdfsdf"),
    
    Location(
        name: "애견카페",
        cityName: "경기 안산시 단원구 중앙동 906",
        coordinate: CLLocationCoordinate2D(latitude: 37.32106300, longitude:  126.80212720),
        description: "...",
        imageNames: ["b05"],
        link: "dfsdfsdf")
    
    
    ]
}

