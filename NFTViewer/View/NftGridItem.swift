//
//  NFTGridItemView.swift
//  NFTViewer
//
//  Created by justyn on 2022-08-22.
//

import Foundation
import Metaplex
import SwiftUI

enum NftMetadataError: Error {
    case missingImage
    case missingMetadata
   }

struct NftGridItem: View {
    @ObservedObject var nftCollectionViewModel:NftCollectionViewModel
    
    private var nft:NFT
    @State private var nftImage:String = ""
    
    init(_ nft: NFT, _ viewModel:NftCollectionViewModel){
        self.nft = nft
        self.nftCollectionViewModel  = viewModel
    }
    
     var body: some View {
             
             Group{
                 VStack{
                     
                         AsyncImage(url: URL(string: self.nftImage)){ phase in
                             if let image = phase.image{
                                 image
                                     .resizable()
                             }else if phase.error != nil{
                                 Color.blue
                             }else{
                                 ProgressView()
                         }
                         }
                         .frame(height: 200)
                         .cornerRadius(10)
                         .shadow(color: Color.primary.opacity(0.3), radius: 1)
                     VStack(alignment: .leading){
                         Text(nft.name)
                             .font(.headline)
                             .frame(alignment: .leading)
                             .minimumScaleFactor(0.8)
                         Text(nft.mint.base58EncodedString)
                             .font(.system(size: 13))
                             .multilineTextAlignment(.leading)
                             .fixedSize(horizontal: false, vertical: true)
                             .frame(alignment: .leading)   
                    }
                     
                 }
                 .frame(minWidth: 0, maxWidth: .infinity)
                 .frame(height: 200)
                 .onAppear{
                     fetchMetadata()
                 }
                 
                 
             }
             
         
     }

    func fetchMetadata(){
        self.nftCollectionViewModel.fetchNftMetadata(nft,self)
    }
    
    func setMetadata(_ metaData:JsonMetadata){
        
        do{
            guard let newImage = metaData.image else{
                throw NftMetadataError.missingImage
            }
            self.nftImage = newImage
        }
        catch{
            self.nftImage = ""
        }
    }
    

}
