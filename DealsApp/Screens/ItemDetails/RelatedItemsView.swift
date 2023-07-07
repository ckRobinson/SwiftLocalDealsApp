//
//  RelatedItemsView.swift
//  DealsApp
//
//  Created by Cameron on 7/7/23.
//

import SwiftUI

struct RelatedItemsView: View {
    
    let relatedDeals: [DealData];
    var body: some View {
        VStack {
            Text("Users who liked this item also liked:")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView(.horizontal) {
                
                HStack {
                    ForEach(relatedDeals) { deal in
                        
                        RelatedItemCard(deal: deal)
                    }
                }
            }
        }
    }
}

private struct RelatedItemCard: View {
    
    let deal: DealData
    var body: some View {
        VStack {
            
            RelatedDealImage
            
            RelatedDealText
        }
        .background(.white)
        .foregroundColor(Color("DarkAccent"))
        .cornerRadius(15)
        .shadow(radius: 4, x: 3, y: 3)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("DarkAccent"), lineWidth: 5)
        })
        .padding()
    }
    
    var RelatedDealImage: some View {
        AsyncImage(url: deal.product.imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, minHeight: 100)
                .padding()
        }
        .cornerRadius(15)
        .padding(.vertical)
    }
    
    var RelatedDealText: some View {
        VStack {
            Text(deal.rawData.title)
                .font(.caption.bold())
                .lineLimit(4, reservesSpace: true)
                .multilineTextAlignment(.leading)
                .frame(width: 150, alignment: .leading)
                .padding(.bottom, 1)
            
            Text(deal.priceString)
                .font(.body)
                .fontWeight(.heavy)
                .foregroundColor(Color("LightAccent"))
                .frame(width: 150, alignment: .leading)
        }
        .padding()
        .background(Color("DarkAccent"))
        .foregroundColor(.white)
    }
}

struct RelatedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        RelatedItemsView_PreviewWrapper()
    }
}

private struct RelatedItemsView_PreviewWrapper: View {
    
    let dealData: [DealData]
    init() {
        let viewModel: HomeViewModel = HomeViewModel();
        
        let itemCount = viewModel.deals.count;
        let slice = min(5, itemCount)
        self.dealData = viewModel.deals[0..<slice].shuffled();
    }
    
    var body: some View {
        RelatedItemsView(relatedDeals: dealData);
    }
}
