//
//  SecterView.swift
//  HanselAndGretel
//
//  Created by Deokhun KIM on 2022/11/16.
//

import SwiftUI
import MapKit
struct TestAPIView: View {
    
    @Environment(\.dismiss) private var dismiss
    var searchNetwork: SearchNetwork = SearchNetwork()
    @EnvironmentObject var viewModel: SearchViewModel
    @ObservedObject var jogakData: JogakData = JogakData()
    @EnvironmentObject private var vm: LocationsViewModel
    
    @State private var searchText: String = ""
//    @State private var testFilter: [Poi] = []
    
    
//    var filterData: [Poi] {
//        if searchText.isEmpty {
//            return viewModel.center!.searchPoiInfo.pois.poi
//        } else {
//            return viewModel.center!.searchPoiInfo.pois.poi.filter
//            {$0.name.localizedStandardContains(searchText)}
//        }
//    }
    
    var filterData: [Poi] {
        Task {
            viewModel.center = try await searchNetwork.loadJson(searchTerm: searchText)
        }
            return viewModel.center!.searchPoiInfo.pois.poi.filter {$0.name.localizedStandardContains(searchText)}


    }

    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.center?.searchPoiInfo.pois.poi.count ?? 0 > 0 {
                    List(filterData,id:\.self) { datum in
//                        Text("\(datum.name)")
                        Button {
                            LocationsDataService.locations.append(
                                Location(
                                    name: datum.name,
                                    cityName: "경기 안산시 단원구 원곡동 906",
                                    coordinate: CLLocationCoordinate2D(latitude: Double(datum.frontLat)!, longitude: Double(datum.frontLon)!),
                                    description: "...",
                                    imageNames: ["b00"],
                                    link: "dfsdfsdf"))
//                            jogakData.datum.append(datum)
                            dismiss()
                            print(LocationsDataService.locations)
                            vm.doSomeThing()
                        } label: {
                            Text("\(datum.name)")
                                .font(.custom("NotoSerifKR-SemiBold", size: 15))
                        }


                    }.searchable(
                        text: $searchText,
                        placement: .navigationBarDrawer,
                        prompt: "장소 검색"
                    )
                }
            }
        }
        .onAppear {
            Task {viewModel.center = try await searchNetwork.loadJson(searchTerm: "초지역")
            }
//            print(viewModel.center?.searchPoiInfo.pois.poi.count)
            
            
        }
    }

}

struct TestAPIView_Previews: PreviewProvider {
    static var previews: some View {
        TestAPIView()
    }
}
