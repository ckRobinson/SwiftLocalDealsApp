//
//  ItemDetailsView.swift
//  DealsApp
//
//  Created by Cameron Robinson on 7/4/23.
//

import SwiftUI

struct ItemDetailsView: View {
    
    let dealData: DealData
    var body: some View {
        ZStack {
            CoreContent
            buyButtonBar
        }
    }
    
    var buyButtonBar: some View {
        
        VStack {
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .border(.gray)
                    .frame(maxWidth: .infinity, maxHeight: 75)
                    .foregroundColor(.white)
                
                Button(action: {}) {
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(width: 125, height: 30)
                            .cornerRadius(15)
                        Text("Buy Now")
                            .frame(width: 150)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
    }
    
    var CoreContent: some View {
        ScrollView {
            AsyncImage(url: dealData.product.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 100)
//                    .padding()
            }
            .cornerRadius(15)
            .padding(.vertical)
            
            Text(dealData.rawData.title)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            HStack {
                VStack {
                    
                    Text("Likes")
                        .font(.footnote.bold())
                    Image(systemName: "hand.thumbsup.fill")
                    Text("\(dealData.rawData.likes.count)")
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Dislikes")
                        .font(.footnote.bold())
                    Image(systemName: "hand.thumbsdown.fill")
                    Text("\(dealData.rawData.dislikes.count)")
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Comments")
                        .font(.footnote.bold())
                    Image(systemName: "text.bubble")
                    Text("\(dealData.rawData.comments.count)")
                }
                .frame(maxWidth: .infinity)
            }
            
            Divider()
            
            Text("Product Desription:")
                .font(.footnote)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 5)
            Text(dealData.rawData.product.description)
                .font(.footnote)
            
            Spacer(minLength: 75)
        }
        .padding(.horizontal)
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail_PreviewWrapper()
    }
}

private struct ItemDetail_PreviewWrapper: View {
    
    let dealData: DealData
    init() {
        let viewModel: HomeViewModel = HomeViewModel();
        self.dealData = viewModel.deals[0];
    }
    
    var body: some View {
        ItemDetailsView(dealData: dealData);
    }
}
