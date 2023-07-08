//
//  RelatedItemsViewModel.swift
//  DealsApp
//
//  Created by Cameron on 7/7/23.
//

import Foundation

class RelatedItemsViewModel: ObservableObject {
    
    @Published var relatedItems: [DealData] = []
    private let dealService: DealsService = DealsService();
    
    func getRelatedItemsFromParent(_ parentDeal: DealData) {
        
        var relatedItems: Set<String> = []
        for like in parentDeal.rawData.likes {
            
            guard let userLikes = like.user.likes else {
                continue;
            }
            
            for like in userLikes {
                relatedItems.insert(like.likedDeal.dealID)
            }
        }
        relatedItems.remove(parentDeal.id)
        
        for relatedItem in relatedItems {
            
            do {
                if let item = try dealService.fetchDealByID(relatedItem) {
                    
                    self.relatedItems.append(DealData(rawData: item))
                }
            }
            catch {
                if let error = error as? APIError {
                    print(error.description);
                }
                else {
                    print(error.localizedDescription);
                }
            }
        }
    }
}
