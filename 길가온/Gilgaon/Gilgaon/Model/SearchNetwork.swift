//
//  APINetwork.swift
//  HanselAndGretel
//
//  Created by kimminho on 2022/11/29.
//

import Foundation

class SearchNetwork {
    //https://apis.openapi.sk.com/tmap/pois?version=1&searchKeyword=\(fetchEncoded(searchTerm))&searchType=all&searchtypCd=A&reqCoordType=WGS84GEO&resCoordType=WGS84GEO&page=1&count=20&multiPoint=Y&poiGroupYn=N
    func fetchEncoded(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
    }
    
    
    func loadJson<T:Decodable>(searchTerm: String) async throws -> T {
//        let url = URL(string: inputUrl)!
        let urlString = "https://apis.openapi.sk.com/tmap/pois?version=1&searchKeyword=\(fetchEncoded(searchTerm))&searchType=all&searchtypCd=A&reqCoordType=WGS84GEO&resCoordType=WGS84GEO&page=1&count=20&multiPoint=Y&poiGroupYn=N"
        
        var request = URLRequest(url: URL(string: urlString)!)
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //사용시에 키값 ❤️지우기

        request.addValue("l7xx8749f7a7b24c491682f94ec946029847", forHTTPHeaderField: "appKey")

        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
//        print(String(data: data, encoding: .utf8))
        
//        do {
//            let decoder = JSONDecoder()
//            let result = try decoder.decode(DataHere.self, from: data)
////            return result
//        } catch DecodingError.dataCorrupted(let context) {
//            print(context)
//        } catch DecodingError.keyNotFound(let key, let context) {
//            print("Key '\(key)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch DecodingError.valueNotFound(let value, let context) {
//            print("Value '\(value)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch DecodingError.typeMismatch(let type, let context) {
//            print("Type '\(type)' mismatch:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch {
//            print("error: ", error)
//        }

    }
}
