//
//  AuthenticationBarView.swift
//  NFTViewer
//
//  Created by justyn on 2022-08-22.
//

import Foundation
import SwiftUI
import UIKit
struct AuthenticationBarView: View {
    @ObservedObject var nftCollectionViewModel:NftCollectionViewModel
    @State private var apiKey:String = ""
    @State private var nftURL:String = ""
    
    var body: some View {
        VStack{
            Text("Metaplex NFT Feed")
                .foregroundLinearGradient(
                    colors: [darkViolet,Color.init(#colorLiteral(red: 0.8509803922, green: 0.6549019608, blue: 0.7803921569, alpha: 1)), Color.init(#colorLiteral(red: 1, green: 0.9882352941, blue: 0.862745098, alpha: 1)),],
                    startPoint: .bottom,
                    endPoint: .top)
                
                .font(Font.system(size: 40, weight: .bold))
                .multilineTextAlignment(.leading)
            
            HStack{
                TextField("Enter API Key",text: $apiKey)
                    .onAppear{
                        if apiKey == ""{
                            apiKey = nftCollectionViewModel.defaultApiKey
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(.roundedBorder)
                    .padding(.all,1)
                
                Button("GO!"){
                    nftCollectionViewModel.fetchNftCollection(apiKey)
                }
                .padding(.all,6)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(UIColor.lightGray),lineWidth:0.25))
                
            }.padding(.all,1)
        }
    }

}

