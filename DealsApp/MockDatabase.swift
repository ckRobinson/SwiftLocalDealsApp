//
//  MockDatabase.swift
//  DealsApp
//
//  Created by Cameron on 7/7/23.
//

import Foundation

class MockDatabase {
    static let shared = MockDatabase();
    
    private var data: [String:ApiDealData] = [:]
    
    init() {
        
        guard let url = Bundle(for: type(of: self)).url(forResource: "getDealsWithAugments", withExtension: "json") else {
            print("\(APIError.invalidUrl) on mockDB init")
            return;
        }
        
        let data = try! Data(contentsOf: url)
        
        var rawDealData: [ApiDealData] = []
        do {
            let result = try JSONDecoder().decode(DealsResponse.self, from: data)
            rawDealData = result.data.deals
        } catch {
            print("\(APIError.decodingError) on mockDB init")
            return;
        }
        
        for rawData in rawDealData {
            self.data[rawData.id] = rawData;
        }
    }
    
    public func loadAllDeals() -> [ApiDealData] {
        let values =  Array(self.data.values).sorted(by: {
            Int($0.id) ?? 0 < Int($1.id) ?? 0
        });
        
//        for val in values {
//            print("\(val.id) - \(val.title)")
//        }
        return values;
    }
    
    public func getDealByID(_ id: String) -> ApiDealData? {
        return self.data[id]
    }
}
