//
//  HomeViewModel.swift
//  DealsApp
//
//  Created by renupunjabi on 7/3/23.
//

import Foundation

class HomeViewModel: ObservableObject {

    @Published var deals: [DealData] = [];
    let dealsService = DealsService();
    init() {
        self.loadDeals()
    }
    
    func loadDeals() {
        let rawDealData = dealsService.fetchDeals();
        self.deals = rawDealData.map({ item in
            DealData(rawData: item);
        })
    }
}
