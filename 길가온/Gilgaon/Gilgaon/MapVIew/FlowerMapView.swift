//
//  ContentView.swift
//  MapAnnotation
//
//  Created by sehooon on 2022/11/30.
//

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
            Task {
                fireStoreViewModel.fetchMarkers(inputID:getStringValue)
            }
            vm.locations = fireStoreViewModel.markerList
            if !vm.locations.isEmpty{
                vm.mapLocation = vm.locations.first!
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

