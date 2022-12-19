//
//  RecordSheetView.swift
//  HanselAndGretel
//
//  Created by zooey on 2022/11/16.
//

import SwiftUI
import PhotosUI

struct WritingView: View {
    @ObservedObject var jogakData: JogakData = JogakData()
    @EnvironmentObject var viewModel: SearchViewModel
    @EnvironmentObject private var cvm: CalendarViewModel
    @Binding var currentDate: Date
    @Binding var calID: [String]
    
    @State private var openPhoto = false
    @State private var openPhoto2 = false
    @State private var openPhoto3 = false
    @State private var image = UIImage()
    @State private var image2 = UIImage()
    @State private var image3 = UIImage()
    @State private var travelName2: String = ""
    @State private var travel: String = ""
    @Environment(\.dismiss) private var dismiss
    @State private var location: [String] = []
    @State private var showModal2 = false
    
    //사진을 보관할 상태 변수
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data? = nil
    
    
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
                            TestAPIView(jogakData: jogakData)
                                .presentationDetents([.medium])
                        }
                    }
                }
                
                
                HStack {
                    
                    Button {
                        self.openPhoto = true
                    } label: {
                        ZStack {
                            Image(systemName: "plus.app")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .fontWeight(.light)
                                .foregroundColor(Color("DarkGray"))
                            Image(uiImage: self.image)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(15)
                        }
                    }
                    .sheet(isPresented: $openPhoto) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                            .onDisappear{
                                jogakData.images.append(image)
                            }
                        
                    }
                    
                    Button {
                        self.openPhoto2 = true
                    } label: {
                        ZStack {
                            Image(systemName: "plus.app")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .fontWeight(.light)
                                .foregroundColor(Color("DarkGray"))
                            
                            Image(uiImage: self.image2)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(15)
                        }
                    }
                    .sheet(isPresented: $openPhoto2) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image2)
                            .onDisappear{
                                jogakData.images.append(image2)
                            }
                    }
                    
                    Button {
                        self.openPhoto3 = true
                    } label: {
                        ZStack {
                            Image(systemName: "plus.app")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .fontWeight(.light)
                                .foregroundColor(Color("DarkGray"))
                            Image(uiImage: self.image3)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(15)
                            
                        }
                    }
                    .sheet(isPresented: $openPhoto3) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image3)
                            .onDisappear{
                                jogakData.images.append(image3)
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
                
//                TaskMetaData(dateTask: [
//                    DateTask(title: "강남 데이투"),
//                    DateTask(title: "놀러가쟈ㅎ_ㅎ"),
//                ], taskDate: getSampleDate(offset: -4)),
                
                Button {
//                    cvm.tasks.append(TaskMetaData(dateTask: [DateTask(title: travelName2)], taskDate: currentDate))
                    cvm.tasks.append(DateTask(title: travelName2,taskDate: currentDate,realDate: calID))
                    print(cvm.tasks)
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
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(currentDate: .constant(Date()),calID: .constant([]))
    }
}
