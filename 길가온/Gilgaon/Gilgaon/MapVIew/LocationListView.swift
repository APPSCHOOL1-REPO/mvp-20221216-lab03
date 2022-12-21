//
//  LocationsListView.swift
//  MapAnnotation
//
//  Created by sehooon on 2022/11/30.
//

//MARK: - 꽃갈피 -> 상단바에 보여지는 리스트들
import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    //l7xx8749f7a7b24c491682f94ec946029847
    
    var body: some View {
        List{
            ForEach(vm.locations){ location in
                Button{
                    vm.showNextLocation(location: location)
                }label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}



extension LocationsListView{
    private func listRowView(location: MarkerModel) -> some View{
        HStack{
            if let imageName = location.photo{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            } else{
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading){
                Text(location.locationName)
                    .font(.custom("NotoSerifKR-SemiBold", size: 17))
                    .foregroundColor(Color("DarkGray"))
                Text(location.createdDate)
                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
                    .foregroundColor(Color("DarkGray"))
            }
            .frame(maxWidth: .infinity,  alignment: .leading)
        }
            
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}
