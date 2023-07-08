//
//  RelatedItemsViewModel.swift
//  DealsApp
//
//  Created by Cameron on 7/7/23.
//

import Foundation

class RelatedItemsViewModel: ObservableObject {
    
    @Published var relatedItems: [DealData] = []
    let dealService: DealsService = DealsService();
    
    func getRelatedItemsFromParent(_ parentDeal: DealData) {
        
        
    }
}
