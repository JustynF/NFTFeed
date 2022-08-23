//
//  HomeView.swift
//  NFTViewer
//
//  Created by justyn on 2022-08-22.
//

import Foundation
import SwiftUI
struct HomeView: View {
    @ObservedObject var nftCollectionViewModel:NftCollectionViewModel

    var body: some View {
        GeometryReader{
            geometry in
            VStack {
                AuthenticationBarView(nftCollectionViewModel: nftCollectionViewModel)
                NftCollectionView(nftCollectionViewModel: nftCollectionViewModel)
                Spacer()
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(nftCollectionViewModel: NftCollectionViewModel())
    }
}
