//
//  WritingView.swift
//  Gilgaon
//
//  Created by sehooon on 2022/12/20.
//

import SwiftUI


struct WritingView: View {
    @ObservedObject var firestoreViewModel:FireStoreViewModel
    
    @ObservedObject var jogakData: JogakData = JogakData()
    @EnvironmentObject var viewModel: SearchViewModel
    
    @State private var travelName2: String = ""
    @State private var travel: String = ""
    @Environment(\.dismiss) private var dismiss
    @State private var location: [String] = []
    @State private var showModal2 = false
    @State private var lanString = ""
    @State private var lonString = ""
    @State private var locationName = ""
    //사진을 보관할 상태 변수
    @State private var selectedImageData: Data? = nil
    
    @State private var shouldShowImagePicker = false
    @State private var image: UIImage?
    
    
    
    
    var body: some View {
        
        ZStack {
            Color("White")
                .ignoresSafeArea()
            VStack{
                ZStack {
                    Image("line")
                        .resizable()
                        .frame(width: 100, height: 70)
                    Text("꽃갈피")
                        .font(.custom("NotoSerifKR-Black", size: 20))
                        .foregroundColor(Color("DarkGray"))
                        .offset(y: -4)
                }
                Spacer()
                
                HStack {
                    NavigationLink {
                        //                        FriendList()
                    } label: {
                        Label("함께", systemImage: "plus")
                    }
                    .foregroundColor(Color("DarkGray"))
                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
                    
                    
                    if location != [] {
                        Text("\(location[0])")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("DarkGray"))
                            .padding(.leading, 100)
                    } else {
                        Button {
                            showModal2.toggle()
                            print(viewModel.center?.searchPoiInfo.pois.poi.count)
                        } label: {
                            HStack() {
                                Image(systemName: "pin.fill")
                                Text("위치")
                            }
                            .foregroundColor(Color("DarkGray"))
                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                            .padding(.leading, 100)
                        }
                        .sheet(isPresented: $showModal2) {
                            TestAPIView(lonString: $lonString, lanString: $lanString, locationName: $locationName)
                            
                                .presentationDetents([.medium])
                        }
                    }
                }
                
                HStack {
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        ZStack {
                            Image(systemName: "plus.app")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .fontWeight(.light)
                                .foregroundColor(Color("DarkGray"))
                            if let image = image{
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                            }
                            
                        }
                    }
                }
                
                TextField("제목", text: $travelName2)
                    .foregroundColor(Color("DarkGray"))
                    .frame(width: 300)
                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
                    .background(.white)
                    .cornerRadius(5)
                    .padding()
                
                TextEditor(text: $travel)
                    .frame(width: 300, height: 300)
                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
                    .foregroundColor(Color("DarkGray"))
                    .background(.white)
                    .cornerRadius(5)
                    .padding()
                
                
                Button {
                    let id = UUID().uuidString
                    let createdAt = Date().timeIntervalSince1970
                    var photoId = ""
                    if let image = image{
                        photoId = UUID().uuidString
                        firestoreViewModel.uploadImageToStorage(userImage: image, photoId: photoId)
                    }
                    let marker = MarkerModel(id: id, title: travelName2, photo: photoId, createdAt: createdAt, contents: travel, locationName: locationName, lat: lanString, lon: lonString)
                    firestoreViewModel.addMarker(marker)
                    dismiss()
                } label: {
                    Text("추가")
                        .frame(width:60,height:40)
                        .font(.custom("NotoSerifKR-SemiBold", size: 17))
                        .background(Color("Pink"))
                        .foregroundColor(Color("White"))
                        .cornerRadius(8)
                }
                
                Spacer()
                
            }
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker) {
            ImagePicker(image: $image)
        }
    }
}

//struct WritingView_Previews: PreviewProvider {
//    static var previews: some View {
//        WritingView()
//    }
//}
