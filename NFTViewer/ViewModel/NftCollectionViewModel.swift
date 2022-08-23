//
//  NftCollectionViewModel.swift
//  NFTViewer
//
//  Created by justyn on 2022-08-22.
//

import Foundation
import SwiftUI

import Metaplex
import Solana

enum NftFetcherError: Error {
    case invalidApiKey
    case httpRequestFailed
    case missingData
   }

@MainActor class NftCollectionViewModel: ObservableObject{
    
    enum NftCollectionState {
        case initial
        case loading
        case sucess(data: [NFT])
        case failed(error: Error)
    }
    
    private(set) var defaultApiKey  = "5LeMDmNW6bQFWQjMhcTZnp6LVHTQQfUpY9jn6YH6RpyE"
    @Published private(set) var state: NftCollectionState = .initial
    @Published private(set) var metadata: JsonMetadata? = nil
    @Published private(set) var nftList:[NFT] = []
    
    lazy var metaplex: Metaplex = {
        let solana = SolanaConnectionDriver(endpoint: RPCEndpoint.mainnetBetaSolana)
        return Metaplex(connection: solana, identityDriver: GuestIdentityDriver(solanaRPC: solana.solanaRPC), storageDriver: URLSharedStorageDriver(urlSession: URLSession.shared))
    }()
    
    func fetchNftCollection(_ apiKey : String){
        print(apiKey)
        
        do{
            self.state = .loading
            guard let ownerPublicKey = PublicKey(string: apiKey) else{
                throw NftFetcherError.invalidApiKey
            }
            
            metaplex.nft.findNftsByOwner(publicKey: ownerPublicKey) { [weak self] result in
                switch result {
                case .success(let nftList):
                    let newNftList = nftList.compactMap{ $0 }
                    self?.nftList = newNftList
                    self?.state = .sucess(data: newNftList)
                case .failure:
                    break
                }
            }
        }
        catch(let error){
            self.state = .failed(error: error)
        }
        
        
    }
    
    func fetchNftMetadata(_ nft:NFT,_ gridItem:NftGridItem){
        
        nft.metadata(metaplex: self.metaplex) { result in
            switch result {
            case .success(let metadata):
                DispatchQueue.main.async {
                    gridItem.setMetadata(metadata)
                }
                
            case .failure(let error):
                break
            }
        }
        
    }
    

    
    

    
    
    
}

