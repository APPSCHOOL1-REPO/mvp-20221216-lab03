//
//  ContentView.swift
//  MapAnnotation
//
//  Created by sehooon on 2022/11/30.
//
/*
12_23(금) 김민호
발견된 문제점: [서랍]에 쌓인 기록들을 클릭하면 배열이 한박자 늦게 받아짐
1.사용자가 클릭시
2.배열을 받을때까지 기다리고
3.맵뷰를 보여주는 순서를 해결하면 될 듯
 async await 공부하러가야딩...
 */


import SwiftUI
import MapKit

struct Place: Identifiable{
    var id = UUID()
    var name: String = ""
    var coordinate: CLLocationCoordinate2D
}

struct FlowerMapView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @ObservedObject var fireStoreViewModel : FireStoreViewModel
    @State var getStringValue: String
    @State private var mapRegion = MKCoordinateRegion()
    @State var userTracking = MapUserTrackingMode.follow
    @State var value = 0
    var body: some View {
        ZStack{
            Map(coordinateRegion: $vm.mapRegion,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $userTracking,
                annotationItems: vm.locations,
                annotationContent: { location in
                MapAnnotation(coordinate: location.coordinate) {
                    mapMarker()
                        .scaleEffect(vm.mapLocation == location ? 1.2: 0.9)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                }
            })
            .onChange(of: fireStoreViewModel.markerList) { newValue in
                vm.locations =  fireStoreViewModel.markerList
                vm.mapLocation = vm.locations.first!

            }
     
            VStack{
                header
                    .padding()
                Spacer()
                ZStack{
                    ForEach(vm.locations) { location in
                        if vm.mapLocation == location{
                            FlowerMapPreview(location:  location)
                                .shadow(color: Color("DarkGray").opacity(0.3), radius: 20)
                                .padding()
                        }
                    }
                }
            }
        }
        .onAppear{
            Task{
                await fireStoreViewModel.fetchMarkers(inputID:getStringValue)
            }
        }
    }
    
    func mapMarker() -> some View {
        Image("flowerPink")
            .resizable()
            .frame(width: 40, height: 40)
            .scaledToFit()
    }
}

extension MKCoordinateRegion: Equatable{
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.center == rhs.center
    }
}

extension CLLocationCoordinate2D:Equatable{
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return (lhs.latitude == rhs.latitude) && (lhs.latitude == lhs.longitude)
    }
    
    
}

extension FlowerMapView {
    var header: some View{
        Button(action: vm.toggleLocationsList){
            VStack{
                Text(vm.mapLocation.locationName)
                    .font(.custom("NotoSerifKR-SemiBold", size: 22))
                    .fontWeight(.black)
                    .foregroundColor(Color("Pink"))
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "chevron.up")
                            .font(.headline)
                            .foregroundColor(Color("DarkGray"))
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
                if vm.showLocationsList{
                    LocationsListView()
                }
                //
            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x:0, y:15)
        }
    }
}



//struct FlowerMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlowerMapView()
//            .environmentObject(LocationsViewModel())
//    }
//}

