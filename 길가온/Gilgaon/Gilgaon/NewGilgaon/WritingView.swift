//
//  WritingView.swift
//  Gilgaon
//
//  Created by sehooon on 2022/12/20.
//

import SwiftUI


struct WritingView: View {
    @ObservedObject var firestoreViewModel:FireStoreViewModel
    
//    @ObservedObject var jogakData: JogakData = JogakData()
    @EnvironmentObject var viewModel: SearchViewModel
    
    @State private var travelName2: String = ""
    @State private var travel: String = ""
    @Environment(\.dismiss) private var dismiss
    @State private var location: [String] = []
    @State private var showModal2 = false
    @State private var showModal3 = false
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

        VStack {
              
            ZStack(alignment: .leading) {
                MyPath3()
                    .stroke(Color("Pink"))
                Text("꽃   갈   피")
                    .font(.custom("NotoSerifKR-Bold", size: 30))
                    .foregroundColor(Color("DarkGray"))
                    .padding(.leading, 50)
            }
            .frame(height: 50)
            .offset(y: -50)
            
            VStack(spacing: 20) {
                HStack {
                    Button {
                        showModal3.toggle()
                    } label: {
                        Label("함께", systemImage: "plus")
                            .foregroundColor(Color("DarkGray"))
                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                    }
                    .sheet(isPresented: $showModal3) {
                        AddFriendView()
                            .presentationDetents([.medium])
                    }
                    Spacer()
                }
                
                HStack {
                    if location != [] {
                        
                        Text("\(locationName)")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("DarkGray"))
                    } else {
                        Button {
                            showModal2.toggle()
                            //                            print(viewModel.center?.searchPoiInfo.pois.poi.count)
                        } label: {
                            HStack() {
                                Image(systemName: "pin.fill")
                                Text("위치")
                                Text(locationName)
                                    .foregroundColor(Color("Red"))
                            }
                            .foregroundColor(Color("DarkGray"))
                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                        }
                        .sheet(isPresented: $showModal2) {
                            TestAPIView(lonString: $lonString, lanString: $lanString, locationName: $locationName)
                                .presentationDetents([.medium])
                        }
                    }
                    Spacer()
                }
            }
            .padding()

            VStack {
                TextField("제목", text: $travelName2)
                    .foregroundColor(Color("DarkGray"))
                    .frame(width: 380)
                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
                
                Divider()
                
                TextField("내용", text: $travel)
                    .foregroundColor(Color("DarkGray"))
                    .frame(width: 380)
                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
            }
            .padding(.bottom, 200)
            
            VStack {
                HStack {
                    Text("사진을 추가해보세요.")
                        .foregroundColor(Color("DarkGray"))
                        .font(.custom("NotoSerifKR-SemiBold", size: 15))
                    Spacer()
                }
                
                HStack {
                    
                    
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        VStack {
                            if let image = image{
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                            } else {
                                Image(systemName: "plus.app")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .fontWeight(.light)
                                    .foregroundColor(Color("DarkGray"))
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
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
            }
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker) {
            ImagePicker(image: $image)
        }
    }
}

struct MyPath3: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.move(to: CGPoint(x: 20, y: 0))
        path.addLine(to: CGPoint(x: 210, y: 0))
        
        path.move(to: CGPoint(x: 20, y: 3))
        path.addLine(to: CGPoint(x: 210, y: 3))
        
        path.move(to: CGPoint(x: 20, y: 50))
        path.addLine(to: CGPoint(x: 210, y: 50))
        
        path.move(to: CGPoint(x: 20, y: 53))
        path.addLine(to: CGPoint(x: 210, y: 53))
        
        path.move(to: CGPoint(x: 40, y: 3))
        path.addLine(to: CGPoint(x: 40, y: 50))
        
        path.move(to: CGPoint(x: 90, y: 3))
        path.addLine(to: CGPoint(x: 90, y: 50))
        
        path.move(to: CGPoint(x: 140, y: 3))
        path.addLine(to: CGPoint(x: 140, y: 50))
        
        path.move(to: CGPoint(x: 190, y: 3))
        path.addLine(to: CGPoint(x: 190, y: 50))
        
        return path
    }
}


struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(firestoreViewModel: FireStoreViewModel())
    }
}
