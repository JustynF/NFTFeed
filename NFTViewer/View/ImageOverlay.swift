//
//  ImageOverlay.swift
//  NFTViewer
//
//  Created by justyn on 2022-08-22.
//

import Foundation
import SwiftUI

struct ImageOverlay: View {
    private var text:String
    init(text: String) {
        self.text = text
    }
    var body: some View {
        ZStack {
            VStack{
                Text(self.text)
                    .font(.callout)
                    .foregroundColor(.white)
            }
            .padding(6)
        }.background(Color.black)
        .opacity(0.8)
        .cornerRadius(10.0)
        .padding(6)
    }
}
