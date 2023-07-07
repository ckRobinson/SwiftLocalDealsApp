//
//  HomeViewDealCard.swift
//  DealsApp
//
//  Created by Cameron on 7/7/23.
//

import SwiftUI

struct DealCard: View {
    let deal: DealData;
    var body: some View {
        
        VStack(alignment: .leading) {
            
            DealImage
            DealInfo
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
    
    var DealImage: some View {
        /// https://swiftwithmajid.com/2021/07/07/mastering-asyncimage-in-swiftui/
        AsyncImage(url: deal.product.imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 300)
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, minHeight: 100)
                .padding()
        }
        .cornerRadius(15)
        .padding()
    }
    
    var DealInfo: some View {
        VStack {
            Text("\(deal.rawData.title)")
                .font(.body.bold())
                .padding(.horizontal)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            Text(deal.priceString)
                .font(.body)
                .fontWeight(.heavy)
                .foregroundColor(Color("LightAccent"))
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Divider()
                .background(.white)
                .padding(.horizontal)
            
            Text(deal.rawData.description)
                .font(.footnote)
                .lineSpacing(4)
                .padding(.vertical)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            DealRatingInfo
        }
        .background(Color("DarkAccent"))
        .foregroundColor(.white)
        .padding(.top)
    }
    
    var DealRatingInfo: some View {
        HStack {
            Image(systemName: "hand.thumbsup.fill")
            Text("\(deal.rawData.likes.count)")
            
            Divider()
            
            Image(systemName: "hand.thumbsdown.fill")
            Text("\(deal.rawData.dislikes.count)")
            
            Spacer()
            
            Text(deal.lastUpdate)
                .font(.caption)
                .fontWeight(.light)
        }
        .frame(maxHeight: 1)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct HomeViewDealCard_Previews: PreviewProvider {
    static var previews: some View {
        DealCardView_PreviewWrapper()
    }
}

private struct DealCardView_PreviewWrapper: View {
    
    let dealData: DealData
    init() {
        let viewModel: HomeViewModel = HomeViewModel();
        self.dealData = viewModel.deals[0];
    }
    
    var body: some View {
        DealCard(deal: dealData);
    }
}
