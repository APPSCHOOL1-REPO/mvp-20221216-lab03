//
//  JogakData.swift
//  Gilgaon
//
//  Created by sehooon on 2022/11/30.
//

import SwiftUI
import MapKit

class JogakData: ObservableObject{
    @Published var friends:[String] = []
    @Published var title: String = ""
    @Published var textbody: String = ""
    @Published var images: [UIImage] = []
    @Published var datum: [Poi] = []
//    @Published var 
}
