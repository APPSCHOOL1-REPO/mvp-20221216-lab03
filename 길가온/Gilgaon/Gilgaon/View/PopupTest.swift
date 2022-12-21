//
//  PopupTest.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/02.
////
//
//import SwiftUI
//import PopupView
//
//
//struct PopupTest: View {
    
    // @State var shouldBottomToastMessage : Bool = false
    // @State var shouldPopupMessage : Bool = false
//
//    var body: some View {
//        ZStack{
//            VStack(spacing: 10){
//
//                Button(action: {
//                    self.shouldBottomToastMessage = true
//                }, label: {
//                    Text("BottomToast")
//                        .font(.system(size: 25))
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.green)
//                        .cornerRadius(10)
//                })
//
//            }// VStack
//            .edgesIgnoringSafeArea(.all)
//        }// ZStack
//        .popup(isPresented: $shouldBottomToastMessage , type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
//            self.createBottomToastMessage()
//        })
//    }
//
////MARK: - PopupView Logic
//    func createBottomToastMessage() -> some View{
//
//            VStack(alignment:.leading){
//                Text("친구추가완료!")
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                Divider() //가중치를 주기 위함
//                    .opacity(0)
//            }
//            .foregroundColor(.white)
//            .padding(15)
//            .frame(width:300)
//            .background(Color.green)
//            .cornerRadius(20)
//
//        }
//
//
//        func createPopupMessage() -> some View{
//            VStack(spacing: 10){
//                Button(action: {
//                    self.shouldPopupMessage = false //버튼을 누르면 닫히도록
//                }){
//                    Text("네")
//                        .font(.system(size: 14))
//                        .foregroundColor(.black)
//                        .fontWeight(.bold)
//                }
//                .frame(width: 100, height: 40)
//                .background(Color.white)
//                .cornerRadius(20)
//            }
//            .padding(.horizontal, 10)
//            .frame(width: 300, height: 400)
//            //        .background(Color(hexcode: "F6B65A"))
//            .cornerRadius(10)
//            .shadow(radius: 10)
//        }
//}
//
////MARK: - Previews
//struct PopupTest_Previews: PreviewProvider {
//    static var previews: some View {
//        PopupTest()
//    }
//}
