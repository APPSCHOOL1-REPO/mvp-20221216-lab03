//
//  MapAnnotationView.swift
//  MapAnnotation
//
//  Created by sehooon on 2022/11/30.
//

import SwiftUI

struct MapAnnotationView: View {
    var body: some View {
        
        Image("flowerPink")
            .resizable()
            .frame(width: 40, height: 40)
            .scaledToFit()
        
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView()
    }
}
