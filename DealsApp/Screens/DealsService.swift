//
//  DealsService.swift
//  DealsApp
//
//  Created by renupunjabi on 7/3/23.
//

import Foundation

class DealsService {
    
    func fetchDeals() throws -> [ApiDealData] {
        return MockDatabase.shared.loadAllDeals()
    }
    
    func fetchDealByID(_ id: String) throws -> ApiDealData? {
        return MockDatabase.shared.getDealByID(id)
    }
}
