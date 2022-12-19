//
//  APIModel.swift
//  HanselAndGretel
//
//  Created by kimminho on 2022/11/29.
//
import SwiftUI
import MapKit

struct DataHere: Codable,Hashable {
    let searchPoiInfo: SearchPoiInfo
}

// MARK: - SearchPoiInfo
struct SearchPoiInfo: Codable,Hashable {
    let pois: Pois
}

// MARK: - Pois
struct Pois: Codable,Hashable {
    let poi: [Poi]
}

// MARK: - Poi
struct Poi: Codable,Hashable {
    let name: String //목적지의 이름
    let frontLat: String //목적지의 위도
    let frontLon: String // 목적지의 경도

}


