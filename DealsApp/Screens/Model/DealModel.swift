//
//  DealModel.swift
//  DealsApp
//
//  Created by Cameron Robinson on 7/3/23.
//

import Foundation

struct DealData: Identifiable{
    let id: String;
    let rawData: ApiDealData;
    let product: ProductData;
    private let price: Float;
    var priceString: String {
        "$\(String(format: "%0.2f", self.price))";
    }
    
    init(rawData: ApiDealData) {
        
        self.rawData = rawData;
        self.id = rawData.id;
        self.product = ProductData(rawData: self.rawData.product);
        
        self.price = Float(rawData.price) / 100.0;
    }
}

struct ProductData {
    
    let rawData: ApiProductData;
    let imageUrl: URL?;
    
    init(rawData: ApiProductData) {
        
        self.rawData = rawData;
        let url = URL(string: rawData.imageURL)
        print("\(url)");
        
        if let url = url {
            self.imageUrl = url;
        }
        else {
            self.imageUrl = nil;
        }
    }
}
