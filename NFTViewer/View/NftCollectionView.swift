//
//  NftGridView.swift
//  NFTViewer
//
//  Created by justyn on 2022-08-22.
//

import Foundation
import SwiftUI
import Metaplex



struct NftCollectionView: View {
    @ObservedObject var nftCollectionViewModel:NftCollectionViewModel
    @State private var gridLayout  = [GridItem(),GridItem()]
     var body: some View {
         

             switch nftCollectionViewModel.state{
             case .sucess(let nftList):
                 ScrollView{
                     LazyVGrid(columns:gridLayout){
                         ForEach(0..<nftList.count,id: \.self){idx in
                             NftGridItem(nftList[idx], nftCollectionViewModel)
                                 .frame(minWidth: 0, maxWidth: .infinity)
                                 .frame(height: 300)
                         }
                     }.padding(.all,1)
                 }
             case .loading:
                 ScrollView{
                     VStack(alignment: .center){
                         Spacer()
                         LoadingView()
                         Spacer()
                     }
                 }
             case .failed(let error):
                 switch error{
                 case NftFetcherError.invalidApiKey:
                     VStack(alignment: .center){
                         Text("Invalid api key")
                     }
                 default:
                     VStack(alignment: .center){
                         EmptyView()
                     }
                 }
             
             default:
                 EmptyView()
             }
         
             
             
         
    }
    
    private func submitUrl(_ key:String,_ url:String) {
        print("request sent")
    }
}

