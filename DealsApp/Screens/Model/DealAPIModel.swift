//
//  DealsModel.swift
//  DealsApp
//
//  Created by Cameron Robinson on 7/3/23.
//

import Foundation

struct DealsResponse: Codable {
    let data: DealsResponseData
}

struct DealsResponseData: Codable {
    let deals: [ApiDealData]
}

struct ApiDealData: Codable, Identifiable, Hashable {
    let id: String;
    let title: String;
    let url: String;
    let price: Int;
    let description: String;
    let product: ApiProductData;
    let createdAt: String;
    let updatedAt: String;
    let likes: [Like];
    let dislikes: [Dislike];
    let comments: [Comment];
}

struct Like: Codable, Hashable {
    let id: String;
    let user: User;
}

struct ApiProductData: Codable, Hashable {
    let availability: String;
    let imageURL: String;
    let description: String;
    let sku: String;
    let updatedAt: String;
    
    enum CodingKeys: String, CodingKey {
        case availability
        case imageURL = "image"
        case description
        case sku
        case updatedAt
    }
}

struct Dislike: Codable, Hashable {
    let id: String;
    let user: User;
}

struct Comment: Codable, Hashable {
    let id: String;
    let createdAt: String;
    let text: String;
    let user: User
}

struct User: Codable, Hashable {
    let id: String?;
    let name: String;
    let likes: [UserLikes]?;
}

struct UserLikes: Codable, Hashable {
    let likedDeal: LikedDeal;
    
    enum CodingKeys: String, CodingKey {
        case likedDeal = "deal"
    }
}

struct LikedDeal: Codable, Hashable {
    let dealID: String
    
    enum CodingKeys: String, CodingKey {
        case dealID = "id"
    }
}
