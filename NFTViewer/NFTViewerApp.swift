//
//  NFTViewerApp.swift
//  NFTViewer
//
//  Created by justyn on 2022-08-22.
//

import SwiftUI
import Metaplex
import Solana

@main
struct NFTViewerApp: App {

    @StateObject var nftCollectionViewModel = NftCollectionViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView(nftCollectionViewModel: nftCollectionViewModel)
        }
    }
}
